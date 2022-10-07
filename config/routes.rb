Rails.application.routes.draw do
  get "/sync", to: "reports#sync"
  get "/export", to: "reports#export"
  root 'static_pages#home'
  devise_for :admins
  resources :reports
  resources :placements, only: [:index]

  
  
end
