# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :posts
    resources :courses
    resources :groups
    resources :users
    resources :comments

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
