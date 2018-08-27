Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'
  
  namespace :api do
    resources :teams, path: '/teams/:league_id(/:year)'
  end
    
  resources :teams, path: '/teams/:league_id(/:year)'
      
end
