Rails.application.routes.draw do
  root 'sessions#new'
  resources :sessions, only: [ :new, :create ]
  resources :games, only: [ :index, :show, :new, :create ] do
    resources :users, only: [ :create ]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
