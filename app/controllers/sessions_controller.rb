class SessionsController < ApplicationController
  def new
    #para o caso de o user estar logado, a pagina de sign up nao tem sentido
    #redirect_to tabs_path if !session[:user_id].nil?
  end

  def create
  	user = User.authenticate(params[:email], params[:password])
  	if user
  		session[:user_id] = user.id #session é uma ação de rails     #estou a criar uma cookie
  		redirect_to tabs_path, :notice => "Logged in!"
  	else
  		flash[:alert] = "Invalid username or password"
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Logged out!"
  end

end
