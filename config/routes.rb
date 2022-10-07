Rails.application.routes.draw do
  get "/sync", to: "reports#sync"
  root 'static_pages#home'
  devise_for :admins
  resources :reports
  resources :placements, only: [:index]

  
  
end
