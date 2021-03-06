# == Route Map
#
#                   Prefix Verb   URI Pattern                                           Controller#Action
#                     root GET    /                                                     kitchens#index
#     kitchen_reservations GET    /kitchens/:kitchen_id/reservations(.:format)          reservations#index
#                          POST   /kitchens/:kitchen_id/reservations(.:format)          reservations#create
#  new_kitchen_reservation GET    /kitchens/:kitchen_id/reservations/new(.:format)      reservations#new
# edit_kitchen_reservation GET    /kitchens/:kitchen_id/reservations/:id/edit(.:format) reservations#edit
#      kitchen_reservation GET    /kitchens/:kitchen_id/reservations/:id(.:format)      reservations#show
#                          PATCH  /kitchens/:kitchen_id/reservations/:id(.:format)      reservations#update
#                          PUT    /kitchens/:kitchen_id/reservations/:id(.:format)      reservations#update
#                          DELETE /kitchens/:kitchen_id/reservations/:id(.:format)      reservations#destroy
#                 kitchens POST   /kitchens(.:format)                                   kitchens#create
#              new_kitchen GET    /kitchens/new(.:format)                               kitchens#new
#             edit_kitchen GET    /kitchens/:id/edit(.:format)                          kitchens#edit
#                  kitchen GET    /kitchens/:id(.:format)                               kitchens#show
#                          PATCH  /kitchens/:id(.:format)                               kitchens#update
#                          PUT    /kitchens/:id(.:format)                               kitchens#update
#                          DELETE /kitchens/:id(.:format)                               kitchens#destroy
#           kitchens_users GET    /users/kitchens(.:format)                             users#kitchens
#                    users GET    /users(.:format)                                      users#index
#                          POST   /users(.:format)                                      users#create
#                 new_user GET    /users/new(.:format)                                  users#new
#                edit_user GET    /users/:id/edit(.:format)                             users#edit
#                     user GET    /users/:id(.:format)                                  users#show
#                          PATCH  /users/:id(.:format)                                  users#update
#                          PUT    /users/:id(.:format)                                  users#update
#                    login POST   /login(.:format)                                      sessions#create
#                  session GET    /session(.:format)                                    sessions#show
#                   logout GET    /logout(.:format)                                     sessions#destroy
#

require 'sidekiq/web'

Rails.application.routes.draw do

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
  end
  
  mount Sidekiq::Web => '/sidekiq'


  root :to => 'users#index'

  resources :kitchens do
    member do
      get 'reservations_all'
      get 'reservations_pending'
      get 'reservations_approved'
      get 'reservations_denied'
    end
  end

  resources :reservations, :only => [:update, :edit]

  resources :kitchens, :except => [:index] do
    resources :reservations, :except => [:update, :edit]
    resources :photos do 
      member do
        get 'set_as_front_page_photo', :action => 'set_as_front_page_photo'
      end
    end
  end

  resources :users, :except => :destroy do
    collection do
      get 'kitchens'
    end
    collection do
      get 'reservations_all'
      get 'reservations_pending'
      get 'reservations_approved'
      get 'reservations_denied'
    end
  end

  controller :sessions do
    get '/auth/facebook/callback', :action => 'create'
    get  '/session',               :action => 'show'
    get '/logout',                 :action => 'destroy',       :as => 'logout'
  end

  #omniauth-facebook routes

  get '/auth/facebook/callback',   :to => 'sessions#create'
  get '/auth/facebook',                                        :as => "facebook_login" 

  controller :static_pages do
    get '/:page_name', :action => 'show', :as => 'page'
  end

end
