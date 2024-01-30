Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: 'flats#index'
  resources :accounts, only: %i[edit update]
  resources :flats do
    get 'photos', to: 'flats#show_photos'
    resources :bookings, only: %i[new create]
    resources :reviews, only: %i[new create]
    resources :likes, only: %i[index create destroy]
  end
end
