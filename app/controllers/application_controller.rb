class ApplicationController < ActionController::Base
  protect_from_forgery

  def clear_session
    session[:type] = nil
    session[:id] = nil
  end

end
