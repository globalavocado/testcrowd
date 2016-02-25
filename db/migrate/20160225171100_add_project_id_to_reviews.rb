class AddProjectIdToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :project, index: true, foreign_key: true
  end
end
