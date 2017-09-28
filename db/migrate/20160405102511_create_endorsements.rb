class CreateEndorsements < ActiveRecord::Migration[4.2]
  def change
    create_table :endorsements do |t|
      t.belongs_to :review, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
