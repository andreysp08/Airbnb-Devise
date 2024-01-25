class Flat < ApplicationRecord
  searchkick text_middle: %i[name address pricing]

  def search_data
    {
      name: name,
      address: address,
      description: description,
      avaliability: avaliability,
      pricing: pricing
    }
  end
  validates :name, presence: true
  belongs_to :user
  has_many_attached :photos
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
