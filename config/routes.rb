Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'
  
  namespace :api do
    resources :users, path: '/users/:league_id(/:year)'
  end
    
  resources :users, path: '/users/:league_id(/:year)'
      
end
