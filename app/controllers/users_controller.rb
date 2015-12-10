class UsersController < ApplicationController

  def new
    #para o caso de o user estar logado, a pagina de sign up nao tem sentido
    #redirect_to tabs_path if !session[:user_id].nil?
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
        session[:user_id] = id.values.first.first
  		  redirect_to tabs_path
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
