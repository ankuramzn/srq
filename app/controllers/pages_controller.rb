class PagesController < ApplicationController
  layout 'pages'

  # Home page for the application
  def root
    clear_session
  end

  # Common login page for Vendors and Users
  def login
    clear_session
  end

  def authenticate
    if params["session_selector"] == "vendor"
      vendor = Vendor.authenticate(params["username"], params["password"])
      if vendor
        session[:type] = "vendor"
        session[:id] = vendor.id
        redirect_to vendor_home_path
      else
        redirect_to log_in_path, :notice => "Login Failed"
      end
    elsif params["session_selector"] == "user"
      user = User.authenticate(params["username"], params["password"])
      if user
        session[:type] = "user"
        session[:id] = user.id
        redirect_to user_home_path
      else
        redirect_to log_in_path, :notice => "Login Failed"
      end
    else
      redirect_to log_in_path, :notice => "Login Failed, please select Type of Login"
    end
  end

  # Common signout page for vendors and users
  def logout
    clear_session
    redirect_to root_path
  end

  def contacts
    clear_session
  end

end
