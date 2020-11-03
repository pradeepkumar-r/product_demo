Rails.application.routes.draw do
  resources :products
  resources :items
  resources :customers
  resources :cart
  post '/cart/clearall', to: 'cart#deleteallItems'
  post '/cart/showitems', to: 'cart#showItems'
  post '/cart/deletefromcart', to: 'cart#deleteFromCart'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
