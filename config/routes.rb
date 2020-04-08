Rails.application.routes.draw do
  get 'notifications/index'
  post 'user_orders/create'
  get 'user_orders/index'
  delete 'user_orders/destroy'
  get 'add_friend', to: 'home#addFriend', as: 'add_friend'
  post 'add_new_friend', to: 'home#addNewFriend', as: 'add_new_friend'
  get 'add_group', to: 'home#addGroup', as: 'add_group'
  get 'add_group/:id', to: 'home#addGroup'
  delete 'group', to: 'home#destroyGroup', as: :delete_group
  get 'home/index'
  post 'orders/:id/finish_order', to: 'orders#finish', as: 'finish_order'
  put 'invites/:id', to: 'invites#join'

  resources :orders
  resources :user_orders
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :notifications do 
    member do
      post :mark_one_as_read 
    end
    collection do
      post :mark_as_read
      post :mark_as_notified
      get :view_all
    end
  end
devise_for :users

root "home#index"

end
