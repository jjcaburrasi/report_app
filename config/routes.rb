Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :admins
  # root "application#hello"
  
end
