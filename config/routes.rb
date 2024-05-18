Rails.application.routes.draw do
  root to: 'onsens#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  get 'users' => 'users#dummy'
  
  resources:users do
    member do
      get :favorites
    end
  end

  resources:onsens do
    collection do
      get 'search'
    end
    resource:favorites, only: [:create, :destroy]
  end
end
