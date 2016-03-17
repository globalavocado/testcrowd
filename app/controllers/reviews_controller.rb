class ReviewsController < ApplicationController

  def new
    @project = Project.find(params[:project_id])
      if @project.reviews.find_by user_id: current_user
        flash[:notice] = 'you cannot review the same project twice.'
        redirect_to projects_path
      elsif user_signed_in?
        @review = Review.new
      else
        flash[:notice] = "you need to be logged in to leave a review."
        redirect_to projects_path
    end
  end

  def create
    @project = Project.find params[:project_id]
    @review = @project.reviews.new params[:review].permit(:thoughts, :rating)
      if @project.reviews.find_by user_id: current_user
        flash[:notice] = 'you cannot review the same project twice.'
        redirect_to projects_path
      else
        @review.user = current_user
        @review.save
        flash[:notice] = "you've successfully left a review!"
        redirect_to projects_path
      end
    end

  def destroy
    @project = Project.find(params[:project_id])
    @review = Review.find(params[:id])
    @review.destroy
      flash[:notice] = 'Review deleted successfully'
    redirect_to projects_path
  end

private

  def review_params
    params.require(:review).permit(:id, :project_id, :thoughts, :rating)
  end

end
