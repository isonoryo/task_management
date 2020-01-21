Rails.application.routes.draw do
  get 'sessions/new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  # root to: 'tasks#index'

  resources :tasks do
    collection do
      post :confirm
    end
  end
end
