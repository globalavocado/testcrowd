class ReviewsController < ApplicationController
	def new
		@project = Project.find(params[:project_id])
		@review = Review.new
	end

	def create
		@project = Project.find(params[:project_id])
		@project.reviews.create(review_params)
		redirect_to projects_path
	end

	def review_params
		params.require(:review).permit(:thoughts, :rating)
	end
end
