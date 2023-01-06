# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :posts do
      resources :reactions
    end
    resources :courses
    resources :course_memberships

    resources :interests
    resources :interest_memberships

    resources :clubs
    resources :club_memberships

    resources :channels
    resources :channel_memberships

    resources :tabs
    resources :rich_text_tabs
    resources :pdf_tabs
    resources :syllabuses

    # this should be placed before "resources :users"
    scope :users, module: :users do
      post '/', to: 'registrations#create', as: :user_registration
    end

    resources :users
    get 'users/:id/feed', to: 'users#feed'
    post 'users/login', to: 'users#login'
  end
end

scope :api do
  scope :v1 do
    use_doorkeeper do
      skip_controllers :autherizations, :applications, :authorized_appplications
    end
  end
end
