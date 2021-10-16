Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :sessions, only: %i[ new create destroy ]
  resources :users, only: %i[ new create show ]
  resources :tasks
end
