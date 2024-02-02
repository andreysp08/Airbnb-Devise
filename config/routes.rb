Rails.application.routes.draw do
  get 'photos/destroy'
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
    resources :bookings, only: %i[new create]
    resources :photos, only: [:destroy]
  end
  # delete "photos/:flat_id/:id", to: "photos#destroy", as: "photo"

  resources :bookings, only: %i[destroy update]
  get "up" => "rails/health#show", as: :rails_health_check
end
