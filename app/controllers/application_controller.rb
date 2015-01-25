class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
 
  def set_locale
    vlocale = params[:locale]
    if vlocale!=nil
      vlocale=vlocale.downcase
    end
    I18n.locale = vlocale || session[:locale] || I18n.default_locale
    session[:locale]=I18n.locale
  end

  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
  	cart = Cart.create
  	session[:cart_id] = cart.id
  	cart
  end
end
