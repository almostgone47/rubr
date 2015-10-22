Rails.application.routes.draw do

  #--- Global ---
  get "sign_in", to: "sessions#new"
  get "sign_out", to: "sessions#destroy"
  get "sign_up", to: "accounts#new"
  post "sign_up", to: "accounts#create"

  resources :sessions

  get "people", to: "pages#people"
  get "/", to: "pages#people"

  get "get_people", to: "pages#get_people"


  post "like_person", to: "pages#like_person"
  post "dislike_person", to: "pages#dislike_person"

  post "send_message", to: "messages#send_message"
  get "messages", to: "messages#index"
  get "messages/:id/", to: "messages#chain"

  resources :accounts
  resources :messages

end
