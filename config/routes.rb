Rails.application.routes.draw do
  resources :products
  resources :items
  resources :customers
  resources :cart
  resources :order
  post '/cart/clearall', to: 'cart#deleteallItems'
  post '/cart/showitems', to: 'cart#showCart'
  post '/cart/deletefromcart', to: 'cart#deleteFromCart'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
