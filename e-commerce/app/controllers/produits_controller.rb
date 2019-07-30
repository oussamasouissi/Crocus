class ProduitsController < ApplicationController

  def index
    @produits = Produit.all
    @categories = Categorie.all
    @marques = Produit.all.distinct.pluck(:marque)
  end

  def show
    @produit = Produit.find(params[:id])

    @produit.update_column('countView', @produit.countViewPlusPlus(@produit.countView) ) if @produit.present?
  end

  def edit
    authorize! :update, Produit
    @produit = Produit.find(params[:id])
  end

  def new
    authorize! :new, Produit
    @produit = Produit.new
    @categories = Categorie.all
  end

  def create
    @produit = Produit.new(product_params)
    if @produit.save
      redirect_to produits_path
    else
      @produit.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    @produit = Produit.find(params[:id])
    if @produit.update(product_params)
      redirect_to produits_path
    else
      render 'edit'
    end
  end

  def destroy
    @produit = Produit.find(params[:id])
    @produit.destroy
    redirect_to produits_path
  end

  def filtreProdMarque
    @categories = Categorie.all
    @marques = Produit.all.distinct.pluck(:marque)
    @produits = Produit.filtreMarque(params[:marque])
  end
  def filtreTriCroissantPrix
    @categories = Categorie.all
    @marques = Produit.all.distinct.pluck(:marque)
    @produits = Produit.filtreCrPrix()
  end
  def filtreTriDecroissantPrix
    @categories = Categorie.all
    @marques = Produit.all.distinct.pluck(:marque)
    @produits = Produit.filtreDcrPrix()
  end

  def listProdFournisseur
    @produits =Produit.where(user_id: current_user.id)
  end
  def homeFournisseur
    @produitsPlusVendus = Produit.limit(6).where(user_id: current_user.id).order(nbrDeVente: :desc)
    @produitsDernierAjout = Produit.limit(3).where(user_id: current_user.id).order(created_at: :desc)
  end



  def statistiquesProduits

    @produits = Produit.limit(5).order(nbrDeVente: :desc)
    @prodlistVente = @produits.map do |p|
      {
          :label => p.nomProduit,
          :value => p.nbrDeVente.to_s
      }
    end






    chartData = {
        "chart": {
            "caption": "Les produits les plus vendus",

            "showValues": "1",
            "showPercentInTooltip": "0",
            "numberPrefix": "Nombre de ventes= ",
            "enableMultiSlicing": "1",
            "theme": "fusion"
        },
        "data": @prodlistVente



    }



    # Chart rendering
    @chart = Fusioncharts::Chart.new({
                                        width: "600",
                                        height: "400",
                                        type: "pie3d",
                                        renderAt: "chart",
                                        dataSource: chartData
                                    })



    # Chart appearance configuration

  end
 private
  def product_params
    params.require(:produit).permit(:id,:nomProduit, :prix , :qteStock , :marque , :remise , :categorie_id  , :image , :user_id)
  end
end
