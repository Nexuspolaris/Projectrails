module ApplicationHelper
  def resource_class
    devise_mapping.to
  end
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def etat_session
    if user_signed_in? 
      #afiche le user, mon compte, et logout
      @User = current_user
      @User.email
      link_to('deconnexion',destroy_user_session_path)
    else
      #lien se connecter
      link_to('Connexion',controller: "user", action: "sign_in")

    end
  end
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

end
