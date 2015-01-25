class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:lockable, :timeoutable,:omniauthable,:omniauth_providers => [:open_id, :github, :google_oauth2, :google, :meetup, :stackexchange]
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email2 = auth.info.email
      user.fname = auth.info.first_name
      user.lname = auth.info.last_name
      user.save!
    end
  end
  def self.from_github(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
        )
      end
    end
  end
  def self.from_meetup(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      p user
      return user
    else
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:'nomail@mail.com',
                           password:Devise.friendly_token[0,20],
      )
    end
  end
    def self.from_stackexchange(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      p user
      return user
    else
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:'nomail@mail.com',
                           password:Devise.friendly_token[0,20],
      )
    end
  end

  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token['user_info']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end    
  end
end
