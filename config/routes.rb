Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/login',   to: 'sessions#new'
  get    '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:show]
  get    '/users/:id/events/:eid', to: 'events#show', as: 'event'
  post   '/users/:id/events', to: 'events#create', as: 'addevent'
  delete '/users/:id/events/:eid', to: 'events#destroy', as: 'delevent'
end
