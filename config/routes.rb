Rails.application.routes.draw do
  resources :users, only: [:create, :show], :defaults => { :format => :json }
  resources :games, :defaults => { :format => :json }
  resources :sessions, only: [:create], :defaults => { :format => :json }
end
