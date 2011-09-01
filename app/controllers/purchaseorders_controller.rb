class PurchaseordersController < ApplicationController

  before_filter :validated_all

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
    @vendor_id = Purchaseorder.find(params[:id]).vendor.id
    respond_to do | format |
        format.js {  }
    end
  end

  def research
  end

  def search
    if vendor_session?
      @purchaseorders = Purchaseorder.by_vendor(session[:id])
    else
      @purchaseorders = Purchaseorder.scoped
    end

    @purchaseorders = @purchaseorders.code_matches(params[:purchaseorder_code]) if !params[:purchaseorder_code].blank?
    @purchaseorders = @purchaseorders.from_date(params[:from_date]) if !params[:from_date].blank?
    @purchaseorders = @purchaseorders.to_date(params[:to_date]) if !params[:to_date].blank?

    if @purchaseorders.blank?
      flash.now[:alert] = "No Matching Purchase Orders found in the system."
      render "research"
    end

  end


end


