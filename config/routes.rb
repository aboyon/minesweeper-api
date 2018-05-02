Rails.application.routes.draw do
  resources :users, only: [:create, :show], :defaults => { :format => :json }
  resources :games, except: [:update, :destroy], :defaults => { :format => :json } do
    member do
      put "reveal/:x/:y" => :reveal
    end
  end
  resources :sessions, only: [:create], :defaults => { :format => :json }
end
