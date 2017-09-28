class Project < ApplicationRecord
    validates :name, length: {minimum: 3}, uniqueness: true
    has_many :reviews, dependent: :destroy
    belongs_to :user

    delegate :email, to: :user

    def average_rating
      return 'N/A' if reviews.none?
      reviews.average(:rating)
    end

end
