Rails.application.routes.draw do
  
  root :to => 'kitchens#index'

  resources :kitchens

  resources :users, :except => :destroy

end
