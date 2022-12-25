Rails.application.routes.draw do
  root 'movies#index'
  
  post 'sessions/login', to: 'sessions#login'
  delete 'sessions/logout', to: 'sessions#logout'
  post 'movies/:id/categories', to: 'movies#add_category'
  delete 'movies/:id/categories', to: 'movies#remove_category'
  post 'movies/:id/rating', to: 'movies#rate_movie'
  get 'categories/:id/movies', to: 'categories#search_movies'
  resources :categories
  resources :movies
  resources :users
  resources :sessions
end
