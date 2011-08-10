require 'aws/s3'

class CompliancesController < ApplicationController

  autocomplete :battery_size, :size

  # GET /compliances
  # GET /compliances.xml
  def index
    @compliances = Compliance.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @compliances }
    end
  end

  # GET /compliances/1
  # GET /compliances/1.xml
  def show
    @compliance = Compliance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @compliance }
    end
  end

  # GET /compliances/new
  # GET /compliances/new.xml
  def new

    @compliance = Compliance.new
    if params[:sku]
      @compliance.sku = params[:sku]
    end
    if params[:vendor_id]
      @compliance.vendor_id = params[:vendor_id]
    elsif session[:type] == "vendor"
      @compliance.vendor_id = session[:id]
    else
      redirect_to sign_up_path
    end
    # A new compliance set always starts as being in the "vendor" status
    @compliance.status = "vendor_input"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @compliance }
    end
  end

  # GET /compliances/1/edit
  def edit
    @compliance = Compliance.find(params[:id])
  end

  # POST /compliances
  # POST /compliances.xml
  def create
    begin
      if !params[:compliance][:documents_attributes].nil? then
        bucket_name = "Vendors/" + Vendor.find(session[:id]).code + "/" + params[:compliance][:sku] + "/" + (Time.now.to_i).to_s

        params[:compliance][:documents_attributes].each { |key, value|
          upload_to_s3(value["file"].original_filename, value["file"], bucket_name)
          value["url"] = "http://s3.amazonaws.com/" + bucket_name + "/" + value["file"].original_filename
          value.delete("file")
        }
      end
      @compliance = Compliance.new(params[:compliance])
      @compliance.last_activity_at = Time.now

      respond_to do |format|
        if @compliance.save
          format.html { redirect_to vendor_asin_compliance_home_path(:sku => @compliance.sku, :vendor_id => @compliance.vendor_id) }
        else
          format.html { render :action => "new" }
        end
      end
    rescue AWS::S3::ResponseError => error
      puts "AWS S3 Response Error Occured"
      raise
    rescue
      if !params[:compliance][:documents_attributes].nil? then
        params[:compliance][:documents_attributes] = {}
      end
      @compliance = Compliance.new(params[:compliance])
      flash.now[:alert] = "An Error occurred during the creation of Compliance Set, Please resubmit with lesser upload files."
      render "new"
    end
  end

  # PUT /compliances/1
  # PUT /compliances/1.xml
  def update

    @compliance = Compliance.find(params[:id])

    # Vendor Session
    if session[:type].eql?("vendor")
      if !params[:compliance][:documents_attributes].nil? then
        if @compliance.documents.nil? || @compliance.documents.empty?
          bucket_name = "Vendors/" + Vendor.find(session[:id]).code + "/" + params[:compliance][:sku] + "/" + (Time.now.to_i).to_s
        else
          bucket_name = "Vendors/" + Vendor.find(session[:id]).code + "/" + params[:compliance][:sku] + "/" + @compliance.documents.first.url.rpartition("/")[0].rpartition("/")[2]
        end

        params[:compliance][:documents_attributes].each { |key, value|
          if value.has_key?("file") then
            begin
              upload_to_s3(value["file"].original_filename, value["file"], bucket_name)
              value["url"] = "http://s3.amazonaws.com/" + bucket_name + "/" + value["file"].original_filename
              value.delete("file")
            rescue
              params[:compliance][:documents_attributes] = {} unless params[:compliance][:documents_attributes].nil?
              @compliance = Compliance.find(params[:id])
              flash.now[:alert] = "An Error occurred during the update of Compliance Set, Please resubmit with lesser upload files."
              render "edit"
              return
            end
          end
        }
      end

      @compliance.last_activity_at = Time.now

      respond_to do |format|
        if @compliance.update_attributes(params[:compliance])
          format.html {
            redirect_to vendor_asin_compliance_home_path(:sku => @compliance.sku, :vendor_id => @compliance.vendor_id)
          }

          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @compliance.errors, :status => :unprocessable_entity }
        end
      end
    else
      # User Session

      if !params[:compliance][:comments_internal].nil? and !@compliance.comments_internal.eql?(params[:compliance][:comments_internal]) then
        @compliance.comments_internal = params[:compliance][:comments_internal]
      end

      if !params[:compliance][:comments_external].nil? and !@compliance.comments_external.eql?(params[:compliance][:comments_external]) then
        @compliance.comments_external = params[:compliance][:comments_external]
      end

      # User approves Compliance Set
      if !params[:compliance][:status].nil? and params[:compliance][:status].eql?("approved") and !"approved".eql?(@compliance.status)
        @compliance.status = "approved"
        # Approve all Purchase Order Asins associated with the Compliance Set
        Asin.by_compliance(@compliance).each do |asin|
          asin.compliance_approved
        end
      end

      # User Rejects Compliance Set
      if !params[:compliance][:status].nil? and params[:compliance][:status].eql?("rejected") and !"rejected".eql?(@compliance.status)
        @compliance.status = "rejected"
        # Clear any associations that Purchase Order Asins have with this Compliance Set
        Asin.by_compliance(@compliance).each do |asin|
          asin.compliance_rejected
        end
      end

      # User Moves Compliance Set back to Vendor
      if !params[:compliance][:status].nil? and params[:compliance][:status].eql?("vendor_input") and !"vendor_input".eql?(@compliance.status)
        @compliance.status = "vendor_input"
        # Passing the Compliance Set back to the Vendor should not have any impact
      end

      @compliance.last_activity_at = Time.now

      respond_to do |format|
        if @compliance.save
          format.html {
            redirect_to user_home_path
          }
          format.xml  { head :ok }
        else
          # TODO Fix this
          format.html { render :action => "edit" }
          format.xml  { render :xml => @compliance.errors, :status => :unprocessable_entity }
        end
      end

    end

  end

  # DELETE /compliances/1
  # DELETE /compliances/1.xml
  def destroy
    @compliance = Compliance.find(params[:id])

    # Any asins that are linked with the compliance set being deleted need to be freed
    Asin.by_compliance(@compliance).each do |asin|
      asin.compliance_rejected
    end
    vendor_id = @compliance.vendor_id
    sku = @compliance.sku
    @compliance.destroy

    respond_to do |format|
      format.html {
        redirect_to vendor_asin_compliance_home_path(:vendor_id => vendor_id, :sku => sku) if session[:type].eql?("vendor")
        redirect_to user_home_path if !session[:type].eql?("vendor")
      }
      format.xml  { head :ok }
    end
  end

  def vendor_asin_compliance_home
    if !params[:vendor_id].nil? && !params[:sku].nil?
      @compliances_vendor = Compliance.by_vendor(Vendor.find(params[:vendor_id])).by_sku(params[:sku]).by_status("vendor_input")
      @compliances_user = Compliance.by_vendor(Vendor.find(params[:vendor_id])).by_sku(params[:sku]).by_status("user_review")
      @compliances_approved = Compliance.by_vendor(Vendor.find(params[:vendor_id])).by_sku(params[:sku]).by_status("approved")

#      TODO: VERIFY IS THIS A GOOD WAY TO PASS THROUGH VALUES
      @sku = params[:sku]
      @vendor_id = params[:vendor_id]
      @compliances = @compliances_vendor | @compliances_user | @compliances_approved
    elsif !params[:vendor_id].nil? && params[:sku].nil?
      @compliances_vendor = Compliance.by_vendor(Vendor.find(params[:vendor_id])).by_status("vendor_input")
      @compliances_user = Compliance.by_vendor(Vendor.find(params[:vendor_id])).by_status("user_review")
      @compliances_approved = Compliance.by_vendor(Vendor.find(params[:vendor_id])).by_status("approved")
      @compliances = @compliances_vendor | @compliances_user | @compliances_approved
      @vendor_id = params[:vendor_id]
    elsif params[:vendor_id].nil? && !params[:sku].nil?
      @compliances_vendor = Compliance.by_sku(params[:sku]).by_status("vendor_input")
      @compliances_user = Compliance.by_sku(params[:sku]).by_status("user_review")
      @compliances_approved = Compliance.by_sku(params[:sku]).by_status("approved")
      @compliances = @compliances_vendor | @compliances_user | @compliances_approved
      @sku = params[:sku]
    else
      @compliances_vendor = Compliance.by_status("vendor_input")
      @compliances_user = Compliance.by_status("user_review")
      @compliances_user = Compliance.by_status("approved")
      @compliances = @compliances_vendor | @compliances_user | @compliances_approved
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @compliances }
    end

  end

  def associate_purchase_orders
    compliance = Compliance.find(params[:compliance_id])
    @vendor = compliance.vendor
    params[:asins].each do |asin|
      asin = Asin.find(asin)
      asin.compliance = compliance
      if compliance.status.eql?("approved")
        asin.compliance_approved
      else
        asin.compliance_associated
      end
    end
    redirect_to vendor_home_path
  end

  def copy
     #Override Clone
    compliance_existing = Compliance.find(params[:id])
    @compliance = compliance_existing.clone
    compliance_existing.labs.each do |existing_lab|
      @compliance.labs << existing_lab.clone
    end
    compliance_existing.documents.each do |existing_document|
      @compliance.documents << existing_document.clone
    end
    @compliance.status = "vendor_input"
    @compliance.save
    flash[:notice] = 'I can haz the Copies and copies ...mmmmm !!!'
    render "edit"
  end
end
