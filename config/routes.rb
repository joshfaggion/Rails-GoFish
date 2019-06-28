Rails.application.routes.draw do
  root 'sessions#new'
  get 'games/instructions'

  resources :sessions, only: [ :new, :create ]

  resources :games do
    member do
      post :fill_with_robots
      patch :play_round
      get :stats
    end
  end
  post 'games/join'
  post 'games/leave'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
