class ChecklistsController < ApplicationController

  def show
    @checklist = Checklist.find_by_id(params[:id])
    @checklist_item = ChecklistItem.new
    @checklist_items = ChecklistItem.find_by_checklist(params[:id])
  end

  def create
    if !params[:checklist][:title].empty?
      id = Checklist.create(params[:checklist][:tab_id], params[:checklist][:title]) 
      if id
        flash[:notice] = "Checklist created successfully"
      else
        flash[:alert] = "Error while creating a checklist"
      end
    else
      flash[:alert] = "You cannot create checklist with empty title"
    end
    redirect_to :back
  end

  def destroy
    Checklist.destroy(params[:id])
    flash[:notice] = "Checklist was deleted"
    redirect_to :back
  end

end
