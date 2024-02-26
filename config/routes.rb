Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
    # Add other controllers as needed
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: 'flats#index'
  get 'owned-places', to: 'flats#show_owned_flats'
  resources :flats do
    get 'photos', to: 'flats#show_photos'
    # get 'contact', to: 'flats#contact'
    resources :bookings, only: %i[new create show destroy]
    resources :reviews, only: %i[new create]
    resources :likes, only: %i[index create destroy]
    get 'open-chat', to: 'flats#open_chat'
  end
  resources :users do
    resources :bookings, only: %i[index]
  end
  resources :chatrooms, only: %i[index show create] do
    resources :messages
  end
end
