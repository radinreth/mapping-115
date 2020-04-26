Rails.application.routes.draw do
  root 'welcome#index'

  namespace :api, format: :json do
    resources :callers, only: [:create]
  end
end
