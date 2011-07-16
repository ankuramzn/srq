class VendorsController < ApplicationController
  layout :choose_layout

  before_filter :do_something

  def do_something
    if session[:type] != "vendor" or session[:id].nil?
      redirect_to log_in_path, :notice => "Please Log in"
    end
  end


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
