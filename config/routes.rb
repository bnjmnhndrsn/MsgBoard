Rails.application.routes.draw do
  root to: "subs#index"
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index, :upvote, :downvote] do
    resources :comments, only: :new
    match "/upvote", to: "posts#upvote", via: 'get'
    match "/downvote", to: "posts#downvote", via: 'get'
  end
  resources :comments, only: [:show, :create, :destroy] do
    match "/upvote", to: "comments#upvote", via: 'get'
    match "/downvote", to: "comments#downvote", via: 'get'
  end
  
end
