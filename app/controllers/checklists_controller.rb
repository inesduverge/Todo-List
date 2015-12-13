class ChecklistsController < ApplicationController

  def create
    if Checklist.validate_title(params[:checklist][:title])
      id = Checklist.create(params[:checklist][:tab_id], params[:checklist][:title]) 
      if id
        flash[:notice] = "Checklist created successfully"
      else
        flash[:alert] = "Error while creating a checklist"
      end
    else
      flash[:alert] = "Title is either too big (20 characters) or empty"
    end
    redirect_to :back
  end

  def destroy
    Checklist.destroy(params[:id])
    flash[:notice] = "Checklist was deleted"
    redirect_to :back
  end

end
