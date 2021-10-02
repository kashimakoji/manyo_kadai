Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  resources :sessions, only: %i[ new create destoy ]
  resources :users, only: %i[ new create show ]
end
