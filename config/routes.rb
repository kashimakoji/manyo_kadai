Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :sessions, only: %i[ new create destroy ]
  resources :users, only: %i[ new create show index ]
  resources :tasks
end
