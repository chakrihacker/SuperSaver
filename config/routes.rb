Rails.application.routes.draw do
  devise_for :users
  
  resources :categories
  resources :deals
  resources :messages
  resources :conversation_memberships
  resources :conversations
  
  get 'welcome/index'
  get 'home/index'

  root "welcome#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
