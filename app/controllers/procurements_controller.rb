class ProcurementsController < ApplicationController

  before_filter :validated_user

  respond_to :html, :only => [:bulk_upload]
  respond_to :js, :only => [:bulk_process]

  def bulk_upload
    respond_with do |format|
      format.html { render :layout => ! request.xhr? }
    end
  end


  def bulk_process
    #puts params[:attachment].original_filename

    @procurements = Array.new

    # Parse and add to application
    FasterCSV.parse(
        params[:attachment].open,
        :headers => true,
        :col_sep => " ",
        :skip_blanks => true) do |row|
      row_hash = row.to_hash
      procurement =  Procurement.new(row_hash["vendor"], row_hash["purchaseorder"], row_hash["asin"], row_hash["date"])
      procurement.process # Adds values to the database
      @procurements << procurement
    end
  end

end

