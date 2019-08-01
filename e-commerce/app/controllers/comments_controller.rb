class CommentsController < ApplicationController
	 def create
    @produit = Produit.find(params[:produit_id])
    @comment = @produit.comments.create(comment_params)
    redirect_to produit_path(@produit)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:rate, :body)
    end
end
