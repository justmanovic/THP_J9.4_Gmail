Rails.application.routes.draw do
  get 'emails/index'
  devise_for :users
  resources :tasks, except: [:show]
  resources :emails
  root to: "emails#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
