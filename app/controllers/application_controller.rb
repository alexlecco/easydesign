class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #before_action :configure_permitted_parameters #metodo para indicar a devise los parametros que debe aceptar la peticion
  include PublicActivity::StoreController
  protect_from_forgery with: :exception

=begin
  private
  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end
=end
end
