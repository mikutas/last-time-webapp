Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/login',   to: 'sessions#new'
  get    '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:show]
  get    '/users/:id/events/:eid', to: 'events#show', as: 'show_event'
  get    '/users/:id/events/:eid/new', to: 'occurred_dates#create', as: 'new_date'
  resources :events, only: [:create, :destroy]
  resources :occurred_dates, only: [:destroy]
end
