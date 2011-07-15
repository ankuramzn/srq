class UsersController < ApplicationController

  layout 'pages'

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => "Thanks for Registering!!!"
    else
      render "new"
    end
  end

end
