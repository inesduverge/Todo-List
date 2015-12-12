class TabsController < ApplicationController

  def index
    @tabs = Tab.find_all_from_user(current_user.id)
    @tab = Tab.new
  end

  def show
    @tabs = Tab.find_all_from_user(current_user.id)
    @new = Tab.new
    
    @tab = Tab.find_by_id(params[:id])
    @share = Share.new
    @checklist = Checklist.new
    @checklists = Checklist.find_all(params[:id])
    @checklist_items = ChecklistItem.find_all
    @checklist_item = ChecklistItem.new
    @note= Note.new
    @notes = Note.find_all(params[:id])
    @users = User.find_all_from_tab(params[:id])
  end

  def create
    @user = current_user
    if !tab_params[:titulo].empty?
      tab_id = Tab.create(tab_params[:titulo], @user.id)
      if tab_id
        #@tab = Tab.find_with_id(tab_id.values.first.first)
        #redirect_to tabs_path
        redirect_to :back
      else
        flash[:alert] = 'There was an error trying to create a tab for you'
        redirect_to tabs_path
      end
    else
      flash[:alert] = "Tab title cannot be empty"
      redirect_to tabs_path
    end
  end

  def update
    id = Tab.update(params[:tab][:id], params[:tab][:titulo])
    if id 
      flash[:notice] = "Tab title updated"
    else
      flash[:alert] = "Could not update tab name"
    end

    redirect_to :back
  end
  
  
  private

  def get_all_items

  end

  def tab_params
    params.require(:tab).permit(:titulo)
  end
end
