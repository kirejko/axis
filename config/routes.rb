# frozen_string_literal: true

Rails.application.routes.draw do
  resources :articles
  devise_for :users

  root to: 'people#index'

  resources :people
end
