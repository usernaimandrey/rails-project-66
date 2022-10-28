# frozen_string_literal: true

Rails.application.routes.draw do
  get '/403', to: 'web/errors#forbidden', as: :not_forbidden_errors
  get '/404', to: 'web/errors#not_found', as: :not_found_errors
  match '/500', to: 'web/errors#server_error', via: :all

  namespace :api do
    resources :checks, only: :create
  end

  scope module: :web do
    root 'home#index'

    resource :session, only: :destroy

    resources :repositories, only: %i[index show new create] do
      delete :clear_cache, on: :collection
      scope module: :repositories do
        resources :checks, only: %i[show create]
      end
    end

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
  end
end
