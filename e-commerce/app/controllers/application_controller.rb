class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
   
    before_action :configure_permitted_parameters, if: :devise_controller?
   
    protected
   
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:UserName, :email, :password, :Name , :CIN, :téléphone, :adresse, :code_postal, :sexe, :roles)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:UserName, :email, :password, :current_password, :Name , :CIN, :téléphone, :adresse, :code_postal, :sexe, :roles)}
   
    end
   end
