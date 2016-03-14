class Review < ActiveRecord::Base
	validates :rating, inclusion: (1..5)
	belongs_to :project
	belongs_to :user

	delegate :email, to: :user

end
