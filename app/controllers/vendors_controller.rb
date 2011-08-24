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

    def bulk_upload
    end

    def bulk_process
      puts params[:attachment].original_filename

      @vendors = Array.new
      @bad_rows = Array.new
      @existing_vendor_rows = Array.new

      row_count = 0

      # Parse and add to application
      FasterCSV.parse(
          params[:attachment].open,
          :headers => true,
          :col_sep => " ",
          :skip_blanks => true) do |row|

        row_count += 1
        row_hash = row.to_hash
        puts row_count.to_s + " - " + row.inspect
        puts row_hash.inspect

        # Use case where the data is missing for the Vendor
        if row_hash['vendor_code'].nil? or  row_hash['contact'].nil? or row_hash['name'].nil?
          puts "BAD ROW - Missing Data"
          @bad_rows << row_count
          next
        end

        begin
          @vendors << Vendor.create!(
                            :code => row_hash['vendor_code'],
                            :contact => row_hash['contact'],
                            :is_import=>true,
                            :name => row_hash['name'],
                            :password=>'123'
                            )
        rescue
          puts "BAD ROW - AR Error"
          @existing_vendor_rows << row_count
          next
        end



      end
    end


end
