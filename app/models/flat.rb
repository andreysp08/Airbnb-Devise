class Flat < ApplicationRecord
  validates :name, presence: true
  has_many_attached :photos
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  belongs_to :user
end
