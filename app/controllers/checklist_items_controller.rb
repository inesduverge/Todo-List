class ChecklistItemsController < ApplicationController
  
  def create
    id = ChecklistItem.create(params[:checklist_item][:checklist_id],
                              params[:checklist_item][:description])
    if id
      flash[:notice] = "Item created successfully"
    else
      flash[:alert] = "Error while creating the item"
    end
    redirect_to checklist_path(params[:checklist_item][:checklist_id])
  end

end
