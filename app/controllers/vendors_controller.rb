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

end
