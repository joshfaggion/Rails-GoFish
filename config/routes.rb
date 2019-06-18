Rails.application.routes.draw do

  get 'sessions/new'
  get 'sessions/create'
  get 'games/new'
  get 'games/index'
  get 'games/create'
  get 'games/show'
  resources :sessions, only: [ :new, :create ]

  root 'sessions#new'

  resources :games, only: [ :index, :show, :new, :create ] do
    resources :users, only: [ :create ]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
