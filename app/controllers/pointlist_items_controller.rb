class PointlistItemsController < ApplicationController
  def create
    level = params[:pointlist_item][:level].to_i + 1
    id = PointlistItem.create(level,
                              params[:pointlist_item][:parent_id],
                              params[:pointlist_item][:pointlist_id],
                              params[:pointlist_item][:title])
    if id
      flash[:notice] = "Point created successfully"
    else
      flash[:alert] = "Error while creating the point"
    end

    redirect_to :back
  end
end
