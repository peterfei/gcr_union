GcrUnion::Application.routes.draw do 
  resources :self_drive_prices
  #resources :comments

  # Make sure this routeset is defined last
  #ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)

  ComfortableMexicanSofa::Routing.admin(:path => '/cms-admin')
  #  # Make sure this routeset is defined last
  #ComfortableMexicanSofa::Routing.content(:path => '/', :sitemap => false)
  resources :value_added_services
  resources :railways
  resources :airports
  resources :manager_users
  resources :car_models
  resources :car_types
  resources :districts
  resources :cities
  resources :car_type_rates
  resources :base_rate_codes
  resources :customers
  resources :shunfengches
  resources :drivers
  resources :phone_validates
  resources :coupons
  resources :self_drive_prices
  resources :reservations do


    match 'dispatch_order' ,:on=>:member
    match 'dispatch_location' ,:on=>:member
    match 'dispatch_car' ,:on=>:member
    match 'execing' ,:on=>:member
    match 'done' ,:on=>:member
    match 'cancel' ,:on=>:member
    resource :comments
    match 'print',:on=>:member
  end
  resources :cars, path_names: { destroy: 'disable' } do
    collection { match :import }
  end
  resources :locations
  resources :companies
  resources :users
  match 'dispatch_car_model'=>"reservations#dispatch_car_model",:as=>"dispatch_car_model"
  match 'users/change_user_status/:id'=>"users#change_user_status",:as=>"change_user_status"
  match 'drivers/change_status/:id' => 'drivers#change_status',:as=>'change_status'
  match 'companies/alter_status/:id' => 'companies#alter_status',:as=>'alter_status'
  # The priority is based upon order of creation:
  # first created -> highest priority.
  get 'welcome' =>"welcome#index"
  match '/signin', :to => 'user_sessions#new'
  match '/signout', :to => 'user_sessions#destroy', :var => :delete
  resources :user_sessions, :only => [:new, :create, :destroy]
  root :to=>"user_sessions#new" 
  resources :sys_parameters
end
