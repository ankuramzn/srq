class PagesController < ApplicationController
  layout 'pages'

  def root
  end


  def login
  end

  def authenticate
    if params["session_selector"] == "vendor"
      vendor = Vendor.authenticate(params["username"], params["password"])
      if vendor
        session[:type] = "vendor"
        session[:id] = vendor.id
        redirect_to :controller => "vendors", :action => "show", :id => vendor.id
      else
        redirect_to log_in_path, :notice => "Login Failed"
      end
    elsif params["session_selector"] == "compliance"
      session[:type] = "compliance"
      redirect_to :controller => "vendors", :action => "index"
    else
      redirect_to log_in_path, :notice => "Login Failed, please select Type of Login"
    end
  end

  def logout
    session[:type] = nil
    session[:id] = nil
    redirect_to root_path
  end

  def contacts
  end

end
