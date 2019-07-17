class CategoriesController < ApplicationController

    def index
      @categorie = Categorie.find(params[:id])

    end
    def edit
      @categorie = Categorie.find(params[:id])
    end
    def show
      #
       @categories = Categorie.all
    end
    def new
      @categorie = Categorie.new
    end
    def create
      @categorie = Categorie.new(categorie_params)

      if @categorie.save
        redirect_to controller: 'categories' ,action: "show" , id: @categorie
      else
        render 'new'
      end
    end
    def destroy
      @categorie = Categorie.find(params[:id])
      @categorie.destroy

      redirect_to category_path
    end
    def update
      @categorie = Categorie.find(params[:id])

      if @categorie.update(categorie_params)
        redirect_to category_path
      else
        render 'edit'
      end
    end
    private
    def categorie_params
      params.require(:categorie).permit(:nomCategorie)
    end

  end