class Project < ActiveRecord::Base
		validates :name, length: {minimum: 3}
		has_many :reviews, dependent: :destroy

end
