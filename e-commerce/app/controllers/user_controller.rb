class UserController < ApplicationController
  def home
    @produits = Produit.all

  end

  def homeAdmin
    authorize! :manage, :all
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:UserName, :email, :password, :password_confirmation, :Name , :CIN, :téléphone, :adresse, :code_postal, :sexe, :roles)
  end
end


