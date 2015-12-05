class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
    user_repeated = User.find_with_email(user_params[:email])
    if !user_repeated.nil?
      flash[:alert] = "Username already in use"
      @user = User.new
      render "new"
    else
      id = User.create(user_params[:email], user_params[:password])
      if id
        flash[:notice] = "User successfully created"
  		  redirect_to log_in_path
  	  else
        @user = User.new
        flash[:alert] = 'Could not create user'
  		  render "new"
  	  end
    end
  end

  private 

  def user_params
  	params.require(:user).permit(:email, :password)
  end
end
