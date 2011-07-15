class PagesController < ApplicationController
  layout 'pages'

  def root
  end


  def login
  end

  def authenticate
    puts params.inspect
    if params[:username]
      user = User.authenticate(params[:username], params[:password])
      if user.nil?
        redirect_to log_in_path, :notice => "Login Failed"
      else
        if user.user_type == 'vendor'
          redirect_to :controller => "vendors", :action => "show", :id => Vendor.first
        else
          redirect_to :controller => "vendors", :action => "index"
        end
      end
    end
  end

  def contacts
  end

end
