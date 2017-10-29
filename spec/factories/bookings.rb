FactoryGirl.define do
  factory :booking_one, class: 'Booking' do
    rental
    start_at DateTime.now + 2.days
    end_at DateTime.now + 12.days
    client_email 'client1@email.com'
    price 10.00
  end

  factory :booking_two, class: 'Booking' do
    rental
    start_at DateTime.now + 1.day
    end_at DateTime.now + 3.day
    client_email 'client2@email.com'
    price 20.00
  end
end
