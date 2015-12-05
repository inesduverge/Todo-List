class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
    user_repeated = User.find_with_email(user_params[:email]).first
    if !user_repeated.nil?
      flash[:alert] = "Username already in use"
      @user = User.new
      redirect_to sign_up_path
    else
      id = User.create(user_params[:email], user_params[:password])
      if id
  		  redirect_to log_in_path
  	  else
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
