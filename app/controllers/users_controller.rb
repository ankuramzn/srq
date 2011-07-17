class UsersController < ApplicationController

  layout 'pages'

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:type] = "user"
      session[:id] = user.id
      redirect_to vendors_list_path, :notice => "Thanks for Registering!!!"
    else
      render "new"
    end
  end

end
