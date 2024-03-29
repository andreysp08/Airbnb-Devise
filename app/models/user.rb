class User < ApplicationRecord
  validates :name, presence: true
  has_many :reviews
  has_many :flats, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
