class CommandesController < ApplicationController
  before_action :set_commande, only: [:edit, :update, :show, :destroy]
  
    def index
      @user = current_user
      @commandes = Commande.where(user_id:@user.id)
    end
  
    def show
    end
  
    def new
      @commande = Commande.new
  
    end
  
    def edit
      @commande = Commande.find(params[:id])
  
    end
  
    def create
  
      @commande = Commande.new(commande_params)
      #@commande.user = User.first
      @commande.update(user_id:current_user.id)
        if @commande.save
          redirect_to @commande
        else
          render 'new'
        end
    end
  
    def destroy
      @commande.destroy
      flash[:danger] ="commande was successfully deleted"
      redirect_to @commande
  
  end
  
    def update
      if @commande.update(commande_params)
          flash[:success] = "command was successfully updated"
          redirect_to @commande
      else
          render 'edit'
      end
  end
  
    private
          def set_commande
              @commande = Commande.find(params[:id])
  
          end
  
    private
      def commande_params
        params.require(:commande).permit(:etat, :quantité)
      end
  
  end
  