Rails.application.routes.draw do
  resources :feeds
  resources :blogs do
    collection do
      post :confirm
    end
    resources :comments
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :favorites, only: [:create, :destroy]
end
