Rails.application.routes.draw do
  root to: 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :posts, only: [:index, :new, :create, :destroy]

  resources :users do
    collection do
      get 'dashboard'
    end
  end

  resources :posts do
    collection do
      get 'search'
      get 'about'
    end
  end

end
