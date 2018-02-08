Rails.application.routes.draw do
  resources :articles
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
