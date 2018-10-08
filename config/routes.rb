Rails.application.routes.draw do
  root 'static_pages#home'
  get    '/about',   to: 'static_pages#about'
  get    '/auth/:provider/callback', to: 'sessions#create', as: 'login'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:edit, :destroy] do
    resources :events, only: [:index, :edit, :update, :create, :destroy] do
      resources :histories, only: [:index, :create, :destroy]
    end
  end
end
