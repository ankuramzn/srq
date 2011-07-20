class UsersController < ApplicationController

  layout :choose_layout

  before_filter :validated_user,    :only => [:home]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:type] = "user"
      session[:id] = @user.id
      redirect_to user_home_path, :notice => "Thanks for Registering!!!"
    else
      render "new"
    end
  end

  def home
    @compliances_user = Compliance.by_status("pc")
    if @compliances_user.empty?
      render :text => "No Compliance Sets to review", :layout => true
    end
  end


end
