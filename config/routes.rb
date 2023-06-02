Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  get 'pages/search', as: 'search'
  get 'pages/dashboard', as: 'dashboard'
  get 'pages/results/:user_id/:id', to: 'pages#results', as: 'results'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :meetings do
      resources :locations
    end
  end

  # Defines the root path route ("/")
  root "pages#search"
end
