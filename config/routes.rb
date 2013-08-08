GcrUnion::Application.routes.draw do
  resources :call_centers
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
      match 'dispatch_location' ,:on=>:member
      match 'dispatch_car' ,:on=>:member 
      match 'execing' ,:on=>:member 
      match 'done' ,:on=>:member 
      match 'cancel' ,:on=>:member
  end
  resources :cars, path_names: { destroy: 'disable' }
  resources :locations
  resources :companies
  match 'drivers/change_status/:id' => 'drivers#change_status',:as=>'change_status'
  match 'companies/alter_status/:id' => 'companies#alter_status',:as=>'alter_status'
  # The priority is based upon order of creation:
  # first created -> highest priority.
  get 'welcome' =>"welcome#index"
  match '/signin', :to => 'user_sessions#new'
  match '/signout', :to => 'user_sessions#destroy', :var => :delete
  resources :user_sessions, :only => [:new, :create, :destroy]
  root :to=>"user_sessions#new"
end
