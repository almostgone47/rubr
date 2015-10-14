Rails.application.routes.draw do

  #--- Global ---
  get "sign_in", to: "sessions#new"
  get "sign_out", to: "sessions#destroy"
  resources :sessions

  get "dashboard", to: "pages#dashboard"

end
