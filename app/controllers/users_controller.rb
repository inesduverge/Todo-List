class UsersController < ApplicationController

  def encrypt_password(password)
    if password.present?
      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
    return { password_salt: password_salt, password_hash: password_hash }
  end

  def new
  	@user = User.new
  end

  def create
    # obtem a conexao com a base de dados
    sql_connection = ActiveRecord::Base.connection

    # encrypts the password
    passwords = encrypt_password(user_params[:password])

    # the insert sql command
    insert_command = "INSERT INTO users (email, password_salt, password_hash, created_at, updated_at) values ('#{user_params[:email]}', '#{passwords[:password_salt]}', '#{passwords[:password_hash]}', '#{Time.now}', '#{Time.now}')"

    # the search user sql command
    select_command = "SELECT * FROM users WHERE email = '#{user_params[:email]}'"

    if !User.find_by_sql(select_command).first.nil?
      flash[:alert] = "Username already in use"
      redirect_to sign_up_path
    else
      sql_connection.execute(insert_command)
      @user = User.find_by_sql(select_command).first
      if !@user.nil?
  		  redirect_to root_url, :notice => "Signed up!"
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
