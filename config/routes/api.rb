# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :posts do
      resources :likes
    end

    resources :courses
    resources :channels
    resources :users
    get 'users/:id/feed', to: 'users#feed'

    scope :users, module: :users do
      post '/', to: 'registrations#create', as: :user_registration
    end
  end
end

scope :api do
  scope :v1 do
    use_doorkeeper do
      skip_controllers :autherizations, :applications, :authorized_appplications
    end
  end
end
