class ProjectsController < ApplicationController

	before_action :authenticate_user!, :except => [:index, :show]

	def index
		@projects = Project.all
	end

	def new
		authenticate_user!
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
		@project.user = current_user
		if @project.save
			redirect_to projects_path
		else
			render 'new'
		end
	end

	def project_params
		params.require(:project).permit(:name)
	end

	def show
		@project = Project.find(params[:id])
	end

	def edit
		@project = Project.find(params[:id])
		if current_user.id != @project.user_id
			flash[:notice] = "you cannot edit somebody else's project."
			redirect_to projects_path
		else
			render 'edit'
		end
	end

	def update
		@project = Project.find(params[:id])
			if current_user.id != @project.user_id
			flash[:notice] = "you cannot edit somebody else's project."
			redirect_to projects_path
		else
			@project.update(project_params)
			flash[:notice] = 'Project edited successfully'
			redirect_to projects_path
		end
	end

	def destroy
		@project = Project.find(params[:id])
		if current_user.id != @project.user_id
			flash[:notice] = "you cannot delete somebody else's project."
			redirect_to projects_path
		else
			@project.destroy
			flash[:notice] = 'Project deleted successfully'
			redirect_to projects_path
		end
	end

end
