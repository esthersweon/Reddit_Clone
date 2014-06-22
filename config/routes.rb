RedditClone::Application.routes.draw do
  root to: "subs#index"
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  resources :subs
  
  resources :posts, only: [:new, :create, :show] do
  	resources :comments, only: [:new, :create, :show]
  end
end
