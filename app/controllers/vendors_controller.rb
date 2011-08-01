class VendorsController < ApplicationController
  layout :choose_layout

  before_filter :validated_all,     :only => [:vendors_purchaseorders]
  #before_filter :validated_vendor,  :only => [:show]
  before_filter :validated_user,    :only => [:index]

  public
    def index
      @vendors = Vendor.all
    end

    def show
      @vendor = Vendor.find(session[:id]) if session[:type].eql?("vendor")
      @vendor = Vendor.find_by_code(params["code"]) if session[:type].eql?("user")
      if @vendor.nil?
        flash.now[:alert] = "No Matching Vendor found in the system."
        render "research"
      end
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

    # Method used by the User to research a specific Vendor
    def research
    end

end
