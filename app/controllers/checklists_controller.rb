class ChecklistsController < ApplicationController

  def show
    @checklist = Checklist.find_by_id(params[:id])
    @checklist_item = ChecklistItem.new
    @checklist_items = ChecklistItem.find_by_checklist(params[:id])
  end

  def create
    id = Checklist.create(params[:checklist][:tab_id], params[:checklist][:title]) 
    if id
      flash[:notice] = "Checklist created successfully"
    else
      flash[:alert] = "Error while creating a checklist"
    end
    redirect_to tab_path(params[:checklist][:tab_id])
  end

end
