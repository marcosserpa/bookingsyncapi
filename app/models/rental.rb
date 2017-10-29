class Rental < ActiveRecord::Base
  has_many :bookings, dependent: :delete_all
end
