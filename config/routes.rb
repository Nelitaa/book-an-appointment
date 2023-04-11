Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # config/routes.rb
  namespace :api do
    namespace :v1 do
      resources :doctors, only: [:index, :create, :destroy]
    end
  end

  get '/member_details' => 'members#index'
end
