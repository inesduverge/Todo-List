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

  def destroy
    Pointlist.destroy(params[:id])
    flash[:notice] = "Pointlist was deleted"
    redirect_to :back
  end

  def update
    id = Pointlist.update(params[:pointlist])
    if id
        flash[:notice] = "Pointlist updated"
      else
        flash[:alert] = "Something went wrong while updating the pointlist"
    end
    redirect_to :back
  end

end
