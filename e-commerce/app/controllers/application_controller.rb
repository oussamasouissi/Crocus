class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource.roles == 'admin'
      user_homeAdmin_path
    else
       user_home_path
    end
  end

  protect_from_forgery with: :exception
   
    before_action :configure_permitted_parameters, if: :devise_controller?
   
    protected
   
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:UserName, :email, :password, :password_confirmation, :Name , :CIN, :téléphone, :adresse, :code_postal, :sexe, :roles)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:UserName, :email, :password, :current_password, :Name , :CIN, :téléphone, :adresse, :code_postal, :sexe, :roles)}
   
    end

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to new_user_session_path, notify: 'Accès interdit'
    end
  end

   