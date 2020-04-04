Rails.application.routes.draw do
  post 'user_orders/create'
  get 'user_orders/index'
  delete 'user_orders/destroy'
  get 'home/index'
  post 'orders/:id/finish_order', to: 'orders#finish', as: 'finish_order'
  resources :orders
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

devise_for :users



end
