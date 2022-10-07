Rails.application.routes.draw do
  get "/sync", to: "reports#sync"
  get "/export", to: "reports#export"
  root 'static_pages#home'
  devise_for :admins
  resources :reports do
    resources :comments, only: [:new, :create]
  end
  resources :placements, only: [:index]
  get '/retrieve', to: 'placements#retrieve'
  get '/export_placements', to: 'placements#export_placements'
  
  
end
