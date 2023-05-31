Rails.application.routes.draw do
  devise_for :users
  get 'pages/search'
  get 'pages/dashboard'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :meetings do
      resources :locations
    end
  end

  # Defines the root path route ("/")
  root "pages#search"
end
