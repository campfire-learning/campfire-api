Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  # root 'users#home'
  root 'users#myposts'

  use_doorkeeper
  get 'users/home'
  resources :posts

  draw :api
end
