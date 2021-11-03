Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :users do
      devise_for :users, singular: :user,
            path: '',
            path_names: {
              sign_in: 'login',
              sign_out: 'logout',
              registration: 'signup'
            },
            controllers: {
              sessions: 'sessions',
              registrations: 'registrations'
            }
      end
      patch '/me', to: 'users#update_profile'
      get '/me', to:'users#profile'
      resources :users, only: [:show], controller: 'users'
      resources :books, only: [:index, :show], controller: 'books'
      resources :rents, only: [:index, :create, :show, :destroy], controller: 'rents'
    end
  end
end
