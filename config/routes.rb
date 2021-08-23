Rails.application.routes.draw do
  root 'home#index'

  resources :sklads do
    resources :deliveries
  end

  resources :deliveries
  resources :sklad_products
  resources :regions
  resources :products
  resources :transfers
end
