class Flat < ApplicationRecord
   has_many :reviews, dependent: :destroy
   validates :name, presence: true
   has_many_attached :photos
end
