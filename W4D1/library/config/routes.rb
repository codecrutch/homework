Rails.application.routes.draw do
  resources :books, only: [:index, :destroy, :create, :new]
end
