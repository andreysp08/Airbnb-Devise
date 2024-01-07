class Review < ApplicationRecord
  belongs_to :flat
  validates :comment, presence: true
end
