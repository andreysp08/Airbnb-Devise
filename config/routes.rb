Rails.application.routes.draw do
  get 'bookings/index'
  get 'bookings/new'
  get 'bookings/create'
  get 'reviews/new'
  get 'reviews/create'
  devise_for :users
  root to: "pages#home"
  # resources :flats, only: %i[index new create show destroy] do
  resources :flats do
    collection do
      get :mybookings
      get :map
    end
    resources :reviews, only: %i[new create]
    resources :bookings, only: %i[new create index]
  end
  resources :bookings, only: %i[destroy update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
