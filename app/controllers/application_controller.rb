class ApplicationController < ActionController::Base
  protect_from_forgery

  def clear_session
    session[:type] = nil
    session[:id] = nil
  end

  def choose_layout
    if [ 'new' ].include? action_name
      'pages'
    else
      'application'
    end
  end

  def validated_all
    if session[:type] != "vendor" and session[:type] != "user"
      redirect_to log_in_path, :notice => "Please Log in to access Compliance details."
    end
  end

  def validated_vendor
    if session[:type] != "vendor" or session[:id].nil?
      redirect_to log_in_path, :notice => "Vendor Please Log in to access Compliance details."
    end
  end

  def validated_user
    if session[:type] != "user" or session[:id].nil?
      redirect_to log_in_path, :notice => "Compliance User Please Log in to access Vendor details."
    end
  end


end
