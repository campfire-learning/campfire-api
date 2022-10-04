# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :posts do
      resources :likes
    end

    resources :courses
    resources :groups
    get 'users/:id/feed', to: 'users#feed'

    # this should be placed before "resources :users"
    scope :users, module: :users do
      post '/', to: 'registrations#create', as: :user_registration
    end

    resources :users
  end
end

scope :api do
  scope :v1 do
    use_doorkeeper do
      skip_controllers :autherizations, :applications, :authorized_appplications
    end
  end
end
