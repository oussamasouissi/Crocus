class ProduitsController < ApplicationController
  def index
    @produits = Produit.all
    @categories = Categorie.all
    @marques = Produit.all.distinct.pluck(:marque)
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
    params.require(:produit).permit(:id,:nomProduit, :prix , :qteStock , :marque , :remise , :categorie_id  , :image)
  end





end
