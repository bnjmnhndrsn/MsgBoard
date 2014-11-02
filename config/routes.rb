Rails.application.routes.draw do
  root to: "subs#index"
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index, :upvote, :downvote] do
    resources :comments, only: :new
    post "upvote", on: :member
    post "downvote", on: :member
  end
  resources :comments, only: [:show, :create, :destroy] do
    post "upvote", on: :member
    post "downvote", on: :member
  end
  
end
