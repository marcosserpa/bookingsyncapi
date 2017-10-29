class Booking < ActiveRecord::Base
  belongs_to :rental

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :client_email, presence: true
  validates :price, presence: true
  validate :validates_booking_overlapping

  scope :search_data_overlapings, lambda { |range|
    where(
      'ID NOT IN (?) AND ((start_at BETWEEN ? AND ? OR end_at BETWEEN ? AND ?) OR (start_at <= ? AND end_at >= ?))',
      range.id, range.start_at, range.end_at, range.start_at, range.end_at, range.start_at, range.end_at
    )
  }

  def validates_booking_overlapping
    return true if start_at.blank? || end_at.blank?

    date_range = Booking.search_data_overlapings(self)

    errors.add(:dates, "informed cannot overlap existent dates to it's rental") if date_range.present?
  end
end
