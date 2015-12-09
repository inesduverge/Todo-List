#esta classe vai ser extendida aos outros controllers todos (nas suas páginas): para poder usar o @current_user em todo o lado
class ApplicationController < ActionController::Base
  helper_method :current_user

  protect_from_forgery with: :exception

  private

  def current_user
  	@current_user ||= User.find_with_id(session[:user_id]) if session[:user_id]
  end
end
