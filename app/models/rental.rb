class Rental < ActiveRecord::Base
  has_many :bookings
end
