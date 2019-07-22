class CategoriesController < ApplicationController

    def index
      @categories = Categorie.all

    end
    def edit
      @categorie = Categorie.find(params[:id])
    end

    def new
      @categorie = Categorie.new
    end
    def create
      @categorie = Categorie.new(categorie_params)

      if @categorie.save
        redirect_to controller: 'categories'
      else
        render 'new'
      end
    end
    def destroy
      @categorie = Categorie.find(params[:id])
      @categorie.destroy

      redirect_to controller: 'categories'
    end
    def update
      @categorie = Categorie.find(params[:id])

      if @categorie.update(categorie_params)
        redirect_to controller: 'categories'
      else
        render 'edit'
      end
    end
    def showFiltreCat
      @categories = Categorie.all
      @marques = Produit.all.distinct.pluck(:marque)
      @categorie = Categorie.find(params[:id])


    end
    protected
    def categorie_params
      params.require(:categorie).permit(:nomCategorie)
    end

  end