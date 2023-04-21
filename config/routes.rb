Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # root 'pages#home'

  # config/routes.rb
  namespace :api do
    namespace :v1 do
      resources :doctors, only: [:index, :create, :destroy]
      resources :reservations, only: [:index, :create, :destroy, :update]
    end
  end

  get '/member_details' => 'members#index'
end
