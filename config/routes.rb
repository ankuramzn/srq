Srq::Application.routes.draw do


  get "sign_up" => "users#new", :as => "sign_up"
  resources :users

  match 'pages/authenticate' => 'pages#authenticate'

  get "log_in" => "pages#login", :as => "log_in"

  get "log_out" => "pages#logout", :as => "log_out"

  root :to => "pages#root"



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

  #get "vendors/index"
  #match 'vendors/index' => 'vendors#index'

  get "vendors_list" => "vendors#index", :as => "vendors_list"

  get "vendor_home" => "vendors#show", :as => "vendor_home"


  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  match 'vendors/vendors_purchaseorders' => 'vendors#vendors_purchaseorders'

  match 'purchaseorders/purchaseorder_asins' => 'purchaseorders#purchaseorder_asins'


  get "vendor_registration" => "vendors#new", :as => "vendor_registration"
  resources :vendors

  get "contacts" => "pages#contacts", :as => "contacts"


end
