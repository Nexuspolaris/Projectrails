
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def open_id
    # You need to implement the method below in your model
    @user = User.find_for_open_id(env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.open:id_data"] = env["openid.ext1"]
      redirect_to new_user_registration_url
    end
  end
  def github
    @user = User.from_github(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "github"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.open:id_data"] = env["openid.ext1"]
      redirect_to new_user_registration_url
    end
  end
  def meetup
    @user = User.from_meetup(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "meetup"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:notice] = I18n.t "devise.omniauth_callbacks.failure", :kind => "meetup", :reason => "erreur"
      session["devise.open:id_data"] = env["openid.ext1"]
      redirect_to new_user_registration_url
    end
  end
  def stackexchange
    p request.env["omniauth.auth"]
    @user = User.from_stackexchange(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "stackexchange"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:notice] = I18n.t "devise.omniauth_callbacks.failure", :kind => "stackexchange", :reason => "erreur"
      session["devise.open:id_data"] = env["openid.ext1"]
      redirect_to new_user_registration_url
    end
  end
end