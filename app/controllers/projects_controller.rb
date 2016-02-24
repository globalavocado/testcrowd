class ProjectsController < ApplicationController
	def index
		@projects = Project.all
	end

	def new
	end

	def create
		Project.create(project_params)
		redirect_to '/projects'
	end

	def project_params
		params.require(:project).permit(:name)
	end
end
