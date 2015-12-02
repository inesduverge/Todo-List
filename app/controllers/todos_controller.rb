class TodosController < ApplicationController

	def index
		@todos = Todo.all
		@todo = Todo.new
	end

	def create
		@todo = Todo.new(todo_params)
		if @todo.save
			flash[:notice] = "Added successfully"
		else
			flash[:danger] = "Oh no something went wrong!"
		end
		redirect_to todos_path
	end

	private

	def todo_params
		params.require(:todo).permit(:item)
	end

end
