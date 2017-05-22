Rails.application.routes.draw do
  resources :users, only: [:show, :update, :destroy, :index, :create]
  # get 'users' => 'users#index'
  # #get 'users/:id' => 'users#show'
  # post 'users' => 'users#create'
  # get 'users/new' => 'users#new'
  #
  # get 'users/:id/edit' => 'users#edit', as: 'edit_user'
  # get 'users/:id' => 'users#show', as: 'show_user'
  # patch 'users/:id' => 'users#update', as: 'update_user'
  # put 'users/:id' => 'users#update'
  # delete 'users/:id' => 'users#destroy', as: 'destroy_user'
  #
end
