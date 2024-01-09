class Flat < ApplicationRecord
   has_many :reviews, dependent: :destroy
   validates :name, presence: true
   has_many_attached :photos
   has_many :bookings, dependent: :destroy
   has_many :users, :through => :Bookings
end
