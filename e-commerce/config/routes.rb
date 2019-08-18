Rails.application.routes.draw do
  root  'user#home'
  resources :produits do
    collection do
      get '/filtreProdMarque/:marque' , to: 'produits#filtreProdMarque' , as: 'filterMarque'
      get '/filtreTriCroissantPrix' , to: 'produits#filtreTriCroissantPrix' , as: 'filterPrix'
      get '/filtreTriDecroissantPrix' , to: 'produits#filtreTriDecroissantPrix' , as: 'filterPrixDec'
      get '/statistiquesProduits' , to: 'produits#statistiquesProduits' , as:'statsProd'
      get '/listProdFournisseur' , to: 'produits#listProdFournisseur' , as:'listProdFour'
      get '/homeFournisseur' , to: 'produits#homeFournisseur' , as:'homeFour'


    end

  end

  resources :categories do

    collection do
      get '/showFiltreCat/:id' , to: 'categories#showFiltreCat' , as: 'filter'
      get '/showFiltreCatBlog/:id' , to: 'categories#showFiltreCatBlog' , as: 'filterBlog'
    end
  end
  resources :commandes do
    collection do
      get '/statistiquesCommande' , to: 'commandes#statistiquesCommande' , as:'statsCommande'
    end
  end
  resources :chat_rooms , only: [:new, :create, :show, :index ,:destroy]
  mount ActionCable.server => '/cable'

  resources :blogs
  resources :user do

    collection do
      get 'homeAdmin'
      get 'home'
      get 'listUsers' , to: 'user#listUsers' , as: 'listUsers'
      get 'statistique' , to:'user#statistiqueUser' , as: 'statistiquesProduits'
    end
end

  devise_for :users , :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }





  get "/:page" => "static#show"

end
