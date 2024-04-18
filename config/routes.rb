Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'users' => 'users#dummy'
  resources:users
end
