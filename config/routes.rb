require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins
  root 'welcome#index'

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end

  resource :manifest, only: [:show]
  resources :caller_logs, only: [:create]
  namespace :api, format: :json do
    resources :callers, only: [:create]
  end
end
