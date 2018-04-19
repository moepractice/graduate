Rails.application.routes.draw do
  resources :contacts
  resources :feeds
  resources :blogs do
    collection do
      post :confirm
    end
    resources :comments
  end
  
  root to: 'blogs#index'
  root to: 'blogs#edit'
  root to: 'blogs#new'
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :favorites, only: [:create, :destroy]
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
