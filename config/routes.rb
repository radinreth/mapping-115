require 'sidekiq/web'
require_relative 'whitelist'

Rails.application.routes.draw do
  devise_for :admins
  root 'welcome#index'

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end

  resource :manifest, only: [:show]
  constraints Whitelist.new do
    resources :caller_logs, path: 'caller_locations', only: [:create]
    namespace :api, format: :json do
      resources :callers, only: [:create]
    end
  end
end
