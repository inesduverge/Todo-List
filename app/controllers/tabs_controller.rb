class TabsController < ApplicationController

  def index
    @tabs = Tab.find_all_from_user(current_user.id)
  end

  def new
  	@tab = Tab.new
  end

  def show
    @tab = Tab.find_by_id(params[:id])
    @share = Share.new
  end

  def create
    @user = current_user
    tab_id = Tab.create(tab_params[:titulo], @user.id)
    puts tab_id
    if tab_id
      @tab = Tab.find_with_id(tab_id.values.first.first)
      redirect_to tabs_path
    else
  	@tab = Tab.new
      flash[:alert] = 'There was an error trying to create a tab for you'
      render "new"
    end
  end

  private

  def tab_params
    params.require(:tab).permit(:titulo)
  end
end
