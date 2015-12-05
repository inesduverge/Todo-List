class SharesController < ApplicationController

  def create 
    user = User.find_with_email(params[:share][:email])
    tab_id = Share.create(user.id, params[:share][:tab_id])
    if tab_id
      flash[:notice] = "Tab successfully shared"
      redirect_to tabs_path
    else
      flash[:notice] = "Tab could not be shared"
      redirect_to tab_path(params[:id])
    end
  end

end
