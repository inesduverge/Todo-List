class PointlistsController < ApplicationController

  def create
    if !params[:pointlist][:title].empty?
      id = Pointlist.create(params[:pointlist][:tab_id], params[:pointlist][:title])
      if id
        flash[:notice] = "PointList created successfully"
      else
        flash[:alert] = "Error while creating a pointlist"
      end
    else
      flash[:alert] = "You cannot create a pointlist with an empty title"
    end

    redirect_to :back
  end

  def destroy
    Pointlist.destroy(params[:id])
    flash[:notice] = "Pointlist was deleted"
    redirect_to :back
  end

end
