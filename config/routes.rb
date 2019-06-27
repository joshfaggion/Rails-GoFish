Rails.application.routes.draw do
  root 'sessions#new'
  resources :sessions, only: [ :new, :create ]
  resources :games, only: [ :index, :show, :new, :create ] do
    resources :users, only: [ :create ]
    member do
      patch :play_round
      get :stats
    end
  end

  post 'games/join'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
