class TasksController < ApplicationController
	def new
		@task = Task.new(:user_id => params[:user_id])
	end
	def create
		@task = Task.new(task_params)
		if @task.save
			flash[:notice] = "Successfully created task!"
			redirect_to @task.user
		else
			render :action => 'new'
		end
	end
	def edit
		@task = current_user.tasks.find(params[:id])
	end
	def update
		@task = current_user.tasks.find(params[:id])
		if @task.update(task_params)
			flash[:notice] = "Successfully updated task!"
			redirect_to @task.user
		else
			render :action => 'edit'
		end
	end
	def destroy
		@task = current_user.tasks.find(params[:id])
		@task.destroy
		flash[:notice] = "Successfully  removed task!"
		redirect_to @task.user
	end
	private
		def task_params
			params.require(:task).permit(:user_id, :task_name, :complete)
		end
end
