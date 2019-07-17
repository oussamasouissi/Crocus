class ProduitsController < ApplicationController
  def show
    @produits = Produit.all

  end
  def edit
    @produit = Produit.find(params[:id])
  end
  def new
    @produit = Produit.new
    @categories = Categorie.all
  end
  def create

    @produit = Produit.new(product_params)

    if @produit.save
      redirect_to controller: 'produits', action: "show" , id: @produit
    else
      @produit.errors.full_messages.to_sentence
      render 'new'
    end
  end
  def update
    @produit = Produit.find(params[:id])

    if @produit.update(product_params)
      redirect_to produit_path
    else
      render 'edit'
    end
  end
  def destroy
    @produit = Produit.find(params[:id])
    @produit.destroy

    redirect_to produit_path
  end
  private
  def product_params
    params.require(:produit).permit(:id,:nomProduit, :prix , :qteStock , :marque , :remise , :categorie_id  , :image)
  end
end
