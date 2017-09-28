class AddProjectIdToReviews < ActiveRecord::Migration[4.2]
  def change
    add_reference :reviews, :project, index: true, foreign_key: true
  end
end
