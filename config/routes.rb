Rails.application.routes.draw do
  resources :products
  resources :items
  resources :customers
  resources :cart
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
