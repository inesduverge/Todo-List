class NotesController < ApplicationController

  def create
    if !params[:note][:title].empty? && !params[:note][:description].empty?
      id = Note.create(params[:note][:tab_id], params[:note][:title], params[:note][:description]) 
      if id
        flash[:notice] = "Note created successfully"
      else
        flash[:alert] = "Error while creating a note"
      end
    else
      flash[:alert] = "You cannot have a note with an empty description and/or title"
    end
    redirect_to :back
  end

  def destroy
    Note.destroy(params[:id])
    flash[:notice] = "Note was deleted"
    redirect_to :back
  end
end
