Rails.application.routes.draw do
  get 'parking_slot/index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :parking_slots
  resources :car_types, only: [:index]
  resources :reservations, only: [:index, :create, :destroy] do
    member do
      patch 'update_status'
    end
  end

  namespace :admin do
    resources :parking_slots, only: [:index, :update]
    resources :customers, only: [:index, :create, :destroy]
    resources :users, only: [:index]
  end  
end