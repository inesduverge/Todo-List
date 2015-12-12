class PointlistsController < ApplicationController

  def create
    id = Pointlist.create(params[:pointlist][:tab_id], params[:pointlist][:title])
    if id
      flash[:notice] = "PointList created successfully"
    else
      flash[:alert] = "Error while creating a pointlist"
    end

    redirect_to :back
  end

end
