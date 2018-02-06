Rails.application.routes.draw do
  root 'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:show, :edit, :destroy]
  get    '/users/:id/events/:eid', to: 'events#show', as: 'show_event'
  post    '/users/:id/events/:eid/create', to: 'occurred_dates#create', as: 'new_date'
  resources :events, only: [:create, :destroy]
  resources :occurred_dates, only: [:destroy]
end
