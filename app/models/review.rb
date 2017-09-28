class Review < ApplicationRecord
  validates :rating, inclusion: (1..5)

  belongs_to :project
  belongs_to :user

  has_many :endorsements

  delegate :email, to: :user

end
