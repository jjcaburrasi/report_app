Rails.application.routes.draw do
  devise_for :admins
  root "application#hello"
  
end
