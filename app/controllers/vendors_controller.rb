class VendorsController < ApplicationController
  layout :choose_layout

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

  private
  def choose_layout
    if [ 'new' ].include? action_name
      'pages'
    else
      'application'
    end
  end


end
