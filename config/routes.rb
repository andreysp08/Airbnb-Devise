Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
  }
  root to: "pages#index"
  resources :flats do
    collection do
      get :autocomplete
      get :mybookings
      get :map
    end
    resources :reviews, only: %i[new create]
    # resources :bookings, only: %i[new create index]
    resources :bookings, only: %i[new create]
  end
  resources :bookings, only: %i[destroy update]
  get "up" => "rails/health#show", as: :rails_health_check
end
