Rails.application.routes.draw do
  root 'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/auth/:provider/callback', to: 'sessions#create', as: 'login'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:show, :edit, :destroy]
  resources :events, only: [:show, :edit, :update, :create, :destroy]
  resources :histories, only: [:create, :destroy]
end
