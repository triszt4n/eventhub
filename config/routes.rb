Rails.application.routes.draw do
  resources :posts
  resources :events
  root to: 'events#index'
end
