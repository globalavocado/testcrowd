class EndorsementsController < ApplicationController
  
  def new
  @review = Review.find(params[:review_id])
      if @review.user_id == current_user.id
        flash[:notice] = 'you cannot endorse your own review.'
        redirect_to projects_path
      else
        @review.endorsements.create
        redirect_to projects_path
      end
  end
  
end
