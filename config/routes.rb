Srq::Application.routes.draw do

  # User related routes
  get "sign_up" => "users#new", :as => "sign_up"
  get "user_home" => "users#home", :as => "user_home"
  resources :users

  # Non model Pages
  match 'pages/authenticate' => 'pages#authenticate'
  get "log_in" => "pages#login", :as => "log_in"
  get "log_out" => "pages#logout", :as => "log_out"
  get "contacts" => "pages#contacts", :as => "contacts"


  # Application Root
  root :to => "pages#root"

  # Asin related routes
  get "asins/index"
  match 'asins/index' => 'asins#index'
  get "asins/show"
  match 'asins/show/:id' => 'asins#show'

  get "asin_status" => "asins#status", :as => "asin_status"
  get "research_asin" => "asins#research", :as => "research_asin"
  match 'purchaseorders/purchaseorder_asins' => 'purchaseorders#purchaseorder_asins'

  # Purchaseorder related routes
  get "purchaseorders/index"
  match 'purchaseorders/index' => 'purchaseorders#index'
  get "purchaseorder_home" => "purchaseorders#show", :as => "purchaseorder_home"
  match 'vendors/vendors_purchaseorders' => 'vendors#vendors_purchaseorders'
  get "research_purchaseorder" => "purchaseorders#research", :as => "research_purchaseorder"


  # Vendor related routes
  get "vendor_registration" => "vendors#new", :as => "vendor_registration"
  get "vendors_list" => "vendors#index", :as => "vendors_list"
  get "vendor_home" => "vendors#show", :as => "vendor_home"
  resources :vendors


  # Compliance Related routes
  match 'compliances/vendor_asin_compliance_management/:vendor_id/:sku' => 'compliances#vendor_asin_compliance_management'
  match 'compliances/associate_purchase_orders' => 'compliances#associate_purchase_orders'
  match 'compliances/:vendor_id/:asin' => 'compliances#index'
  resources :compliances



end
