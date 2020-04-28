require 'sidekiq/web'

Rails.application.routes.draw do
  root 'welcome#index'

  mount Sidekiq::Web => '/sidekiq'
  resource :manifest, only: [:show]
  resources :caller_logs, only: [:create]
  namespace :api, format: :json do
    resources :callers, only: [:create]
  end
end
