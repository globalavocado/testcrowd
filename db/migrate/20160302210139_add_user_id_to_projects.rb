class AddUserIdToProjects < ActiveRecord::Migration[4.2]
  def change
    add_reference :projects, :user, index: true, foreign_key: true
  end
end
