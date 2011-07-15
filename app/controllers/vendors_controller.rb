class VendorsController < ApplicationController

  def index
    @vendors = Vendor.all
  end

  def show
    @vendor = Vendor.find(params[:id])
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
    puts @vendor.inspect
    if @vendor.save
      redirect_to :controller => "vendors", :action => "show", :id => @vendor.id
    else
      render "new"
    end
  end

end
