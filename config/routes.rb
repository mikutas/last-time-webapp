Rails.application.routes.draw do
  root 'static_pages#home'
  get    '/about', to: 'static_pages#about'
  get    '/auth/:provider/callback', to: 'sessions#create', as: 'login'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: %i[edit destroy] do
    resources :events, only: %i[index edit update create destroy] do
      resources :histories, only: %i[index create destroy]
    end
  end
end
