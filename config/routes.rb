# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }

  # No need to login while developing on localhost :)
  unless Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  # admin routes
  namespace :admin do
    authenticate :user, ->(user) { user.admin? } do
      # Sidekiq
      require 'sidekiq/web'
      mount Sidekiq::Web => '/sidekiq'
    end

    # Manage departments
    resources :departments, only: %i[index new create edit update destroy]

    # Manage users
    # resources :users
  end

  root to: 'dashboard#index'

  get '*unmatched_route', to: 'application#raise_not_found'
end
