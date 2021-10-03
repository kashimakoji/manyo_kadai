Rails.application.routes.draw do
  get 'sessions/new'
  resources :sessions, only: %i[ new create destroy ]
  resources :users, only: %i[ new create show ]
  resources :tasks
end
