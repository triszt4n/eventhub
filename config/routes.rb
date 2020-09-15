Rails.application.routes.draw do
  post 'sessions/create', to: 'sessions#create' , as: 'login'
  match 'sessions/destroy', to: 'sessions#destroy' , as: 'logout', via: [:get, :delete]
  get 'auth', to: 'users#auth', as: 'auth'

  get 'register', to: 'users#new', as: 'register'
  post 'register', to: 'user#create'

  get 'users/:id/edit', to: 'users#edit', as: 'profile_edit'
  put 'users/:id/update', to: 'users#update', as: 'profile_update'

  get 'users/:id', to: 'users#show', as: 'profile'
  get 'users', to: 'users#index', as: 'users'

  get 'forgotten', to: 'users#forgotten', as: 'forgotten'
  post 'send_forgotten', to: 'users#send_forgotten', as: 'send_forgotten'

  get 'users/:id/change_pw', to: 'users#change_pw', as: 'change_pw'
  put 'users/:id/send_change_pw', to: 'users#send_change_pw', as: 'send_change_pw'

  resources :posts
  resources :events

  root to: 'events#index'
end
