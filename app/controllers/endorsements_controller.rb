class EndorsementsController < ApplicationController
  
  def new
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    redirect_to projects_path
  end
  
end
