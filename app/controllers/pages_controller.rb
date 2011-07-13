class PagesController < ApplicationController
  layout 'pages'

  def login
  end

  def authenticate
    puts params.inspect
    if params[:session_selector].equal?("vendor") && !Vendor.find_by_code(params[:code]).nil?
      puts "Found Vendor"
      redirect_to :controller => "vendors", :action => "show", :id => Vendor.find_by_code(params[:code]).id
    elsif params[:session_selector].equal?("pc")
      redirect_to :controller => "compliances", :action => "index"
    else
#      redirect_to :login, :locals => { :notice => 'Compliance was successfully created.' }
      redirect_to( :action => "login" , :notice => 'Compliance was successfully created.')
    end


  end

end
