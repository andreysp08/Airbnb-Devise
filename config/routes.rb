Rails.application.routes.draw do
  get 'photos/destroy'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
  }
  root to: "pages#index"
  delete '/delete_an_image/' => 'flats#delete_an_image', as: :delete_an_image
  resources :flats do
    # member do
    #   delete :delete_photo
    # end
    # member do
    # end
    collection do
      # delete :delete_image_attachment
      get :autocomplete
      get :mybookings
      get :map
    end
    resources :reviews, only: %i[new create]
    # resources :bookings, only: %i[new create index]
    resources :bookings, only: %i[new create]
    # resources :photos, only: %i[destroy]
  end
  resources :bookings, only: %i[destroy update]
  get "up" => "rails/health#show", as: :rails_health_check
end
