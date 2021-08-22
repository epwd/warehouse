Rails.application.routes.draw do
  root 'home#index'

  resources :sklads do
    resources :deliveries
  end
  resources :deliveries
  resources :sklad_products
  resources :history_transfers
  resources :history_deliveries
  resources :regions
  resources :products
end
