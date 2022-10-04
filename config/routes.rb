# frozen_string_literal: true

Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'users#home'

  devise_for :users

  draw :api
end
