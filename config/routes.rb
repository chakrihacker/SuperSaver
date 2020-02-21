Rails.application.routes.draw do
  devise_for :users

  # Api
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      devise_scope :user do
        post "/register", to: "users/registrations#create"
        post "/login", to: "users/sessions#create"
      end
      post "/social_login", to: "users/social_login#create"
    end
  end
  
  resources :categories
  resources :deals
  resources :messages
  resources :conversation_memberships
  resources :conversations

  scope 'api' do
    scope 'v1' do
      resources :deals, only: [:show, :index, :create]
      resources :categories, only: [:show, :index]
      resources :conversations
      post "/conversations/create_chat", to: "conversations#create_chat"
    end
  end
  
  get 'welcome/index'
  get "home", to: "home#index"

  root "welcome#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
