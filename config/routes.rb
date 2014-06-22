RedditClone::Application.routes.draw do
  root to: "subs#index"
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :destroy]

  resources :subs do
    resources :posts, only: [:new, :create]
  end

  resources :posts, only: :show do
  	resources :comments, only: [:create]
  end
end
