Rails.application.routes.draw do
  get 'user_orders/index'
  post 'user_orders/create'
  get 'add_friend', to: 'home#addFriend', as: 'add_friend'
  get 'home/index'
  post 'orders/:id/finish_order', to: 'orders#finish', as: 'finish_order'
  resources :orders
  resources :user_orders
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

devise_for :users



end
