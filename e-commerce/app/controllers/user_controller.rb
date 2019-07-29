class UserController < ApplicationController
  def home
  end

  def homeAdmin
    authorize! :manage, :all
    @user = User.find(current_user.id)
  end
  def listUsers
    @clients = User.where(roles: "client")
    @fournisseurs = User.where(roles: "fournisseur",status: "accepté")
@demandes = User.where.not("description= '' and nomSociete= '' and numFournisseur= '' or status= 'accepté'  " )
  end
  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to listUsers_user_index_path
    else
      render 'edit'
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to listUsers_user_index_path
  end
  private
  def user_params
    params.require(:user).permit(:id,:email, :Name , :CIN , :téléphone , :adresse , :code_postal  , :roles, :UserName , :status , :description , :nomSociete , :numFournisseur)
  end

end


