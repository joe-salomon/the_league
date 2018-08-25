Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'
  
  resources :users, path: '/:league_id/users' do
    
  end
end
