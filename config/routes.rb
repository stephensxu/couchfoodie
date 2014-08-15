Rails.application.routes.draw do

  root :to => 'kitchens#index'

  resources :kitchens

  resources :users, :except => :destroy

  controller :sessions do
    post '/login',          :action => 'create',        :as => 'login'
    get  '/session',        :action => 'show'
    get '/logout',          :action => 'destroy',       :as => 'logout'
  end

end
