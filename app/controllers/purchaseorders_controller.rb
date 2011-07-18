class PurchaseordersController < ApplicationController


  #  TODO Only certain parties should be able to use thins function
  def index
    @purchaseorders = Purchaseorder.all
  end

  def show
    if params[:id]
      @purchaseorder = Purchaseorder.find(params[:id]) unless (session[:type] == "vendor" && Purchaseorder.find(params[:id]).vendor_id != session[:id])
    elsif params[:purchaseorder_id]
      @purchaseorder = Purchaseorder.find_by_code(params[:purchaseorder_id]) unless (session[:type] == "vendor" && Purchaseorder.find_by_code(params[:purchaseorder_id]).vendor_id != session[:id])
    end
    if @purchaseorder.nil?
      redirect_to research_purchaseorder_path, :notice => "The requested Purchase Order could not be found"
    end
  end

  def purchaseorder_asins
    @asins = Purchaseorder.find(params[:id]).asins
    @id = params[:id]
    respond_to do | format |
        format.js {  }
    end
  end

  def research
  end

end
