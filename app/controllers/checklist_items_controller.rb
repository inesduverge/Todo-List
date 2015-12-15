class ChecklistItemsController < ApplicationController
  
  def create
    puts "########"
    puts params[:checklist_item][:checklist_id]

    if !params[:checklist_item][:description].empty?
      id = ChecklistItem.create(params[:checklist_item][:checklist_id],
                                params[:checklist_item][:description])
      if id
        flash[:notice] = "Item created successfully"
      else
        flash[:alert] = "Error while creating the item"
      end
    else
      flash[:alert] = "You cannot create an empty item"
    end
    redirect_to :back
  end

  def update
    if !params[:checklist_item][:description].empty?
      id = ChecklistItem.update(params[:checklist_item])
      if id
        flash[:notice] = "Checklist Item updated!"
      else
        flash[:alert] = "Something went wrong while updating your checklist item"
      end
    else
      flash[:alert] = "You cannot update an item with an empty title"
    end
    redirect_to :back
  end

  def destroy
    ChecklistItem.destroy(params[:id])
    redirect_to :back
  end

end
