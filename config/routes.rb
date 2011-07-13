Srq::Application.routes.draw do

  match 'pages/login' => 'pages#login', :as => :signup
  match 'pages/authenticate' => 'pages#authenticate'
  get "pages/login"

  match 'compliances/vendor_asin_compliance_management/:vendor_id/:sku' => 'compliances#vendor_asin_compliance_management'
  match 'compliances/associate_purchase_orders' => 'compliances#associate_purchase_orders'

  resources :compliances
  match 'compliances/:vendor_id/:asin' => 'compliances#index'


  get "asins/index"
  match 'asins/index' => 'asins#index'

  get "asins/show"
  match 'asins/show/:id' => 'asins#show'

  get "purchaseorders/index"
  match 'purchaseorders/index' => 'purchaseorders#index'

  get "purchaseorders/show"
  match 'purchaseorders/show/:id' => 'purchaseorders#show'

  get "vendors/index"
  match 'vendors/index' => 'vendors#index'

  get "vendors/show"
  match 'vendors/show/:id' => 'vendors#show', :as => :vendor
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)



  match 'vendors/vendors_purchaseorders' => 'vendors#vendors_purchaseorders'

  match 'purchaseorders/purchaseorder_asins' => 'purchaseorders#purchaseorder_asins'

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
