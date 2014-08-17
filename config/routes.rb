Rails.application.routes.draw do

  root :to => 'kitchens#index'

  resources :kitchens, :except => :index do
    resources :reservations
  end

  resources :users, :except => :destroy do
    collection do
      get 'kitchens'
    end
  end

  controller :sessions do
    post '/login',          :action => 'create',        :as => 'login'
    get  '/session',        :action => 'show'
    get '/logout',          :action => 'destroy',       :as => 'logout'
  end

end
