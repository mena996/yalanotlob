Rails.application.routes.draw do
  get 'notifications/index'
  post 'user_orders/create'
  get 'user_orders/index'
  delete 'user_orders/destroy'
  get 'add_friend', to: 'home#addFriend', as: 'add_friend'
  get 'remove_friend/:id',to: 'home#removeFriend', as: 'remove_friend'
  post 'add_new_friend', to: 'home#addNewFriend', as: 'add_new_friend'
  post 'add_new_group', to: 'home#addNewGroup', as: 'add_new_group'
  post 'add_new_group_user/:id', to: 'home#addNewGroupUser', as: 'add_new_group_user'
  get 'add_group', to: 'home#addGroup', as: 'add_group'
  get 'add_group/:id', to: 'home#addGroup',as: 'group'
  delete 'group/:id', to: 'home#destroyGroup', as: :delete_group
  delete ':gid/group_user/:uid', to: 'home#destroyGroupUser', as: :delete_group_user
  get 'home/index'
  post 'orders/:id/finish_order', to: 'orders#finish', as: 'finish_order'
  put 'invites/:id', to: 'invites#join'
  delete 'invites/:id', to: 'invites#destroy'
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
