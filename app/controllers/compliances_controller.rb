class CompliancesController < ApplicationController
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

    @compliance.status = "vendor"
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

    if !params[:compliance][:documents_attributes].nil? then
      params[:compliance][:documents_attributes].each { |key, value|
        value["url"] = value["file"].original_filename
        value.delete("file")
      }
    end

    @compliance = Compliance.new(params[:compliance])
    @compliance.last_activity_at = Time.now

    respond_to do |format|
      if @compliance.save
        format.html {
#          redirect_to(@compliance, :notice => 'Compliance was successfully created.')
          redirect_to :controller =>  "compliances", :action => "vendor_asin_compliance_management", :sku => @compliance.sku, :vendor_id => @compliance.vendor_id
        }
        format.xml  { render :xml => @compliance, :status => :created, :location => @compliance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @compliance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /compliances/1
  # PUT /compliances/1.xml
  def update
    @compliance = Compliance.find(params[:id])

    if !params[:compliance][:documents_attributes].nil? then
      params[:compliance][:documents_attributes].each { |key, value|
        if value.has_key?("file") then
          value["url"] = value["file"].original_filename
          value.delete("file")
        end
      }
    end

    @compliance.last_activity_at = Time.now

    respond_to do |format|
      if @compliance.update_attributes(params[:compliance])
        format.html {
#          redirect_to(@compliance, :notice => 'Compliance was successfully updated.')
          redirect_to :controller =>  "compliances", :action => "vendor_asin_compliance_management", :sku => @compliance.sku, :vendor_id => @compliance.vendor_id
        }

        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @compliance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /compliances/1
  # DELETE /compliances/1.xml
  def destroy
    @compliance = Compliance.find(params[:id])
    @compliance.destroy

    respond_to do |format|
      format.html { redirect_to(compliances_url) }
      format.xml  { head :ok }
    end
  end

  def vendor_asin_compliance_management
    puts params.inspect
    if !params[:vendor_id].nil? && !params[:sku].nil?
      @compliances_vendor = Compliance.by_vendor(Vendor.find(params[:vendor_id])).by_asin(params[:sku]).by_status("vendor")
      @compliances_pc = Compliance.by_vendor(Vendor.find(params[:vendor_id])).by_asin(params[:sku]).by_status("pc")

#      TODO: VERIFY IS THIS A GOOD WAY TO PASS THROUGH VALUES
      @sku = params[:sku]
      @vendor_id = params[:vendor_id]
    elsif !params[:vendor_id].nil? && params[:sku].nil?
      @compliances_vendor = Compliance.by_vendor(Vendor.find(params[:vendor_id])).by_status("vendor")
      @compliances_pc = Compliance.by_vendor(Vendor.find(params[:vendor_id])).by_status("pc")
      @compliances = @compliances_vendor | @compliances_pc
      @vendor_id = params[:vendor_id]
    elsif params[:vendor_id].nil? && !params[:sku].nil?
      @compliances_vendor = Compliance.by_asin(params[:sku]).by_status("vendor")
      @compliances_pc = Compliance.by_asin(params[:sku]).by_status("pc")
      @compliances = @compliances_vendor | @compliances_pc
      @sku = params[:sku]
    else
      @compliances_vendor = Compliance.by_status("vendor")
      @compliances_pc = Compliance.by_status("pc")
      @compliances = @compliances_vendor | @compliances_pc
    end

    puts "Vendor " + @compliances_vendor.length.to_s + " PC " + @compliances_pc.length.to_s
    @asins = Vendor.find(params[:vendor_id]).asins.by_sku(params[:sku])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @compliances }
    end

  end

  def associate_purchase_orders
    puts params.inspect

    compliance = Compliance.find(params[:compliance_id])
    @vendor = compliance.vendor
    params[:asins].each do |asin|
      asin = Asin.find(asin)
      asin.compliance = compliance
      asin.status = "vendor_input_complete"
      asin.save
    end

#    TODO : Why is this not working
#    render vendor_url(:id => compliance.vendor_id)
#    render :template => "vendors/show"
#     render( "vendors/show", :locals => { :id => compliance.vendor_id})
#   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
# This route can be invoked with purchase_url(:id => product.id)

    redirect_to :controller => "vendors", :action => "show", :id => compliance.vendor_id

  end
end
