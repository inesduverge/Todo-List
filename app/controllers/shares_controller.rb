class SharesController < ApplicationController

  def create 
    if !params[:share][:email].empty?
      user = User.find_with_email(params[:share][:email])
      tab_id = Share.create(user.id, params[:share][:tab_id])
      if tab_id
        flash[:notice] = "Tab successfully shared"
      else
        flash[:alert] = "Tab could not be shared"
      end
    else
      flash[:alert] = "Empty email"
    end
    redirect_to :back
  end

end
