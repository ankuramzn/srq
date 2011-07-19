class AsinsController < ApplicationController

  before_filter :validated_all

  # TODO See who needs access to this function
  def index
    @asins = Asin.all
  end

  def show
    @asin = Asin.find(params[:id])
  end

  def research
  end

  def status
    if session[:type] == "vendor"
      #  Purchase Orders for the Vendor which contain the ASIN
      @purchaseorders = Vendor.find(session[:id]).sku_purchaseorders(params[:sku])

      # Compliance Sets submitted by the Vendor for the ASIN
      @compliances = Compliance.by_asin(params[:sku]).by_vendor(session[:id])
    end

    if session[:type] == "user"
      # All Purchase Orders containing the sku
      @purchaseorders = Purchaseorder.contains_sku(params[:sku])


      # All Compliance Sets for the ASIN submitted by any Vendor
      @compliances = Compliance.by_asin(params[:sku])
    end
  end

end
