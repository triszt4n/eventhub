Rails.application.routes.draw do
  post 'sessions/create', to: 'sessions#create' , as: 'login'
  match 'sessions/destroy', to: 'sessions#destroy' , as: 'logout', via: [:get, :delete]
  get 'auth', to: 'sessions#auth', as: 'auth'

  resources :users, only: [:index, :show, :new, :create, :update, :edit]
  get 'users/:id/follows', to: 'users#follows', as: 'follows'
  get 'users/:id/change_pw', to: 'users#change_pw', as: 'change_pw'
  post 'users/:id/send_change_pw', to: 'users#send_change_pw', as: 'send_change_pw'
  get 'forgotten', to: 'users#forgotten', as: 'forgotten'
  post 'send_forgotten', to: 'users#send_forgotten', as: 'send_forgotten'
  post 'users/:id/follow', to: 'users#follow', as: 'user_follow'

  resources :events
  post 'events/:id/follow', to: 'events#follow', as: 'event_follow'

  resources :posts, only: [:show, :edit, :create, :new, :update, :destroy]

  root to: 'events#index'
end
