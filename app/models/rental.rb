class Rental < ActiveRecord::Base
  has_many :bookings, dependent: :delete_all

  validates :name, presence: true
  validates :daily_rate, presence: true
end
