class Review < ApplicationRecord
  belongs_to :flat
  belongs_to :user
  validates :comment, presence: true
  validates :rating, inclusion: { in: 0..5 }
end
