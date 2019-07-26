Rails.application.routes.draw do

  resources :produits do
    collection do
      get '/filtreProdMarque/:marque' , to: 'produits#filtreProdMarque' , as: 'filterMarque'
      get '/filtreTriCroissantPrix' , to: 'produits#filtreTriCroissantPrix' , as: 'filterPrix'
      get '/filtreTriDecroissantPrix' , to: 'produits#filtreTriDecroissantPrix' , as: 'filterPrixDec'
      get '/statistiquesProduits' , to: 'produits#statistiquesProduits' , as:'statsProd'


    end

  end

  resources :categories do

    collection do
      get '/showFiltreCat/:id' , to: 'categories#showFiltreCat' , as: 'filter'
    end
  end
  resources :commandes

  get 'user/homeAdmin'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'user/home'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
