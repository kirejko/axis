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
    authenticated :user, ->(user) { user.admin? } do
      require 'sidekiq/web'
      mount Sidekiq::Web => '/sidekiq'
    end

    resources :departments, except: :show
    resources :users

    # Admin root path
    root 'dashboard#index'
  end

  # people
  resources :people, only: %i[index show]

  # app root
  root 'dashboard#index'

  # all unmatched routes
  get '*unmatched_route', to: 'application#raise_not_found'
end
