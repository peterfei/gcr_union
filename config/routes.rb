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
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
