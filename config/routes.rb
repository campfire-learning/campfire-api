Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'users#home'

  use_doorkeeper
  get 'users/home'
  resources :posts
  devise_for :users

  draw :api
end
