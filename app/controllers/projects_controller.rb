class ProjectsController < ApplicationController
	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
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
	end

	def update
		@project = Project.find(params[:id])
		@project.update(project_params)
		redirect_to '/projects'
	end

	def destroy
		@projects = Project.find(params[:id])
		@projects.destroy
		flash[:notice] = 'Project deleted successfully'
		redirect_to '/projects'
	end

end
