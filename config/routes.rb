Rails.application.routes.draw do
  devise_for :users
  resources :comments
  get 'sessions/new'

  resources :blogs do
    collection do
      post :confirm
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :comments, only:[:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
