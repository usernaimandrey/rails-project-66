# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :checks, only: :create
  end

  scope module: :web do
    root 'home#index'

    resource :session, only: :destroy

    resource :cache, only: :destroy

    resources :repositories, only: %i[index show new create] do
      scope module: :repositories do
        resources :checks, only: %i[show create]
      end
    end

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
  end
end
