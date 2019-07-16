Rails.application.routes.draw do
  resources :categories
  get 'user/homeAdmin'
  devise_for :users
  get 'user/home'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
