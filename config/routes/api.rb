# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :posts do
      resources :likes
    end

    resources :courses
    resources :groups
    resources :users

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
