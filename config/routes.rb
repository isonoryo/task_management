Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]

  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :users

  namespace :admin do
   resources :users
 end

end
