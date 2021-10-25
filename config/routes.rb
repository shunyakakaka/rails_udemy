Rails.application.routes.draw do
  resources :boards
  resources :comments, only: [:create, :destroy]
end
