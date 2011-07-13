class PurchaseordersController < ApplicationController
  def index
    @purchaseorders = Purchaseorder.all
  end

  def show
    @purchaseorder = Purchaseorder.find(params[:id])
  end

  def purchaseorder_asins
    @asins = Purchaseorder.find(params[:id]).asins
    @id = params[:id]
    respond_to do | format |
        format.js {  }
    end
  end
end
