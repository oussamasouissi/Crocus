class BlogsController < ApplicationController

  def index
    @articles = Blog.all
    @categories = Categorie.where(categorieType: "blog")
    @recentArticle=Blog.order(created_at: :desc)
  end


  def new
    @blog = Blog.new
  end
  def show
    @article = Blog.find(params[:id])
    @categories = Categorie.where(categorieType: "blog")
    @recentArticle=Blog.order(created_at: :desc)
  end

  def create
    @blog = Blog.new(product_params)
    if @blog.save
      redirect_to blogs_path
    else
      @blog.errors.full_messages.to_sentence
      render 'new'
    end
  end
  def destroy
    @article = Blog.find(params[:id])
    @article.destroy
    redirect_to blogs_path
  end

  def edit

    @blog = Blog.find(params[:id])
  end
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(product_params)
      redirect_to blogs_path
    else
      render 'edit'
    end
  end
  
  

  private
  def product_params
    params.require(:blog).permit(:id,:nom ,:description , :categorie_id , :created_at , :updated_at ,:image )
  end
end
