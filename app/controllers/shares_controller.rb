class SharesController < ApplicationController

  def create
    user = User.find_with_email(params[:share][:email])
    shared_already = Share.find(params[:share][:tab_id], user)
    if shared_already.nil?
      tab_id = Share.create(user.id, params[:share][:tab_id])

      if tab_id
        flash[:notice] = "Tab successfully shared"
        redirect_to :back
      else
        flash[:alert] = "Tab could not be shared"
        redirect_to :back
      end
    else
      flash[:alert] = "Tab was already shared with that user"
      redirect_to :back
    end
  end

end
