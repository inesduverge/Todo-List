class TabsController < ApplicationController

  def index
    @tabs = Tab.find_all_from_user(current_user.id)
    @tab = Tab.new
  end

  def show
    # Share logic
    if !Tab.find_with_id(params[:id]).nil?
      @share = Share.new
      @users = User.find_all_from_tab(params[:id])

      # Tabs logic
      @tabs = Tab.find_all_from_user(current_user.id)
      @new = Tab.new
      @tab = Tab.find_by_id(params[:id])

      # Checklists Logic
      @checklist = Checklist.new
      @checklists = Checklist.find_all(params[:id])
      @checklist_items = ChecklistItem.find_all(params[:id])
      @checklist_item = ChecklistItem.new

      # Notes Logic
      @note= Note.new
      @notes = Note.find_all(params[:id])

      # PointLists Logic
      @pointlists = Pointlist.find_all(params[:id])
      @pointlist = Pointlist.new
      @pointlist_items = PointlistItem.find_all_items(params[:id])
      @pointlist_item = PointlistItem.new
    else
      flash[:alert] = "Tab was deleted"
      redirect_to tabs_path
    end
  end

  def create
    @user = current_user
    if Tab.validate_title(tab_params[:titulo])
      tab_id = Tab.create(tab_params[:titulo], @user.id)
      if tab_id
        flash[:notice] = "Tab created successfully"
      else
        flash[:alert] = 'There was an error trying to create a tab for you'
      end
    else
      flash[:alert] = "Tab title is either empty or too long(15 chars max)"
      redirect_to :back
      return
    end
    redirect_to tab_path(tab_id.values.first)
  end

  def update
    if Tab.validate_title(params[:tab][:titulo])
      id = Tab.update(params[:tab][:id], params[:tab][:titulo])
      if id
        flash[:notice] = "Tab title updated"
      else
        flash[:alert] = "Could not update tab name"
      end
    else
      flash[:alert] = "The title cannot be empty nor too long(10 chars max)"
    end

    redirect_to :back
  end

  def destroy
    Tab.destroy(params[:id])
    flash[:notice] = "Tab was deleted"
    redirect_to tabs_path
  end


  private

  def tab_params
    params.require(:tab).permit(:titulo)
  end
end
