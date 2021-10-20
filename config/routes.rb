Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :labels, only: %i[ new create destroy edit update ]
  end
  root to: 'tasks#index'
  resources :sessions, only: %i[ new create destroy ]
  resources :users, only: %i[ new create show ]
  resources :tasks
end
