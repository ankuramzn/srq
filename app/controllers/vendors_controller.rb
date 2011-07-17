class VendorsController < ApplicationController
  layout :choose_layout

  before_filter :validated_user, :only => [:vendors_purchaseorders]
  before_filter :validated_vendor, :only => [:show]
  before_filter :validated_compliance, :only => [:index]

  public
    def index
      @vendors = Vendor.all
    end

    def show
      @vendor = Vendor.find(session[:id])
    end


    def vendors_purchaseorders

      @purchaseorders = Vendor.find( params[:id] ).purchaseorders
      @id = params[:id]
      respond_to do | format |
          format.js {  }
      end

    end

    def new
      @vendor = Vendor.new
    end

    def create
      @vendor = Vendor.new(params[:vendor])
      if @vendor.save
        session[:type] = "vendor"
        session[:id] = @vendor.id
        redirect_to vendor_home_path
      else
        render "new"
      end
    end

  private

    def choose_layout
      if [ 'new' ].include? action_name
        'pages'
      else
        'application'
      end
    end

    def validated_user
      if session[:type] != "vendor" and session[:type] != "user"
        redirect_to log_in_path, :notice => "Please Log in to access Compliance details."
      end
    end

    def validated_vendor
      if session[:type] != "vendor" or session[:id].nil?
        redirect_to log_in_path, :notice => "Vendor Please Log in to access Compliance details."
      end
    end

    def validated_compliance
      if session[:type] != "user"
        redirect_to log_in_path, :notice => "Compliance User Please Log in to access Vendor details."
      end
    end

end
