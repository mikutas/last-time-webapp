Rails.application.routes.draw do
  root 'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:show, :edit, :destroy]
  resources :events, only: [:show, :create, :destroy]
  resources :occurred_dates, only: [:create, :destroy]
end
