class Flat < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many_attached :photos
  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # seach
  # include PgSearch::Model
  # pg_search_scope :global_search,
  # against: [ :name, :address ],
  # associated_against: {
  #   user: [ :name, :email ]
  # },
  # using: {
  #   tsearch: { prefix: true }
  # }
  searchkick
end
