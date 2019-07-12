Rails.application.routes.draw do
  get 'welcome/homeAdmin'
  devise_for :users
  get 'welcome/home'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
