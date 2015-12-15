class NotesController < ApplicationController

  def create
    if Note.validate(params[:note])
      id = Note.create(params[:note])
      if id
        flash[:notice] = "Note created successfully"
      else
        flash[:alert] = "Error while creating a note"
      end
    else
      flash[:alert] = "You cannot have a note with no title and/or more than 25 characters"
    end
    redirect_to tab_path(params[:note][:tab_id]) + "#profile"
  end

  def update
    if Note.validate(params[:note])
      id = Note.update(params[:note])
      if id
        flash[:notice] = "Note successfully updated"
      else
        flash[:alert] = "You were not able to update the note"
      end
    else
      flash[:alert] = "You cannot update a note with empty parameters"
    end
    redirect_to tab_path(params[:note][:tab_id]) + "#profile"
  end

  def destroy
    Note.destroy(params[:id])
    flash[:notice] = "Note was deleted"
    redirect_to tab_path(params[:tab_id]) + "#profile"
  end
end
