class ReviewsController < ApplicationController
	def new
		@project = Project.find(params[:project_id])
		@review = Review.new
	end

	def create
		@project = Project.find params[:project_id]
		@review = @project.reviews.new params[:review].permit(:thoughts, :rating)
			if @project.reviews.find_by user_id: current_user.id
				flash[:notice] = 'you cannot review the same project twice.'
				redirect_to projects_path
			else
				@review.user = current_user
				@review.save
				flash[:notice] = "you've successfully left a review!"
				redirect_to projects_path
			end
	end

	# def review_params
	# 	params.require(:review).permit(:thoughts, :rating)
	# end
end
