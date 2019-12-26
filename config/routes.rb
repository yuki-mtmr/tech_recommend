Rails.application.routes.draw do
  root to: 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :posts, only: [:index, :new, :create, :destroy]

  resources :users, only: [:show]

  resources :posts do
    collection do
      get 'search'
      get 'about'
    end
  end

  resources :categories do
    collection do
      get 'ruby'
      get 'rails'
      get 'aws'
      get 'js'
      get 'docker'
    end
  end

  resources :profiles, only: [:new, :create, :edit, :update]


end
