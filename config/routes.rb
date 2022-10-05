Rails.application.routes.draw do
  get 'reports/index'
  root 'static_pages#home'
  devise_for :admins
  resources :reports
  
  
end
