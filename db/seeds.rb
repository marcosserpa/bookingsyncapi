# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

rental_one = Rental.create(name: 'Rental One', daily_rate: 1.5)
rental_two = Rental.create(name: 'Rental Two', daily_rate: 2.0)

b1_start = DateTime.now + 2.days
b1_end = DateTime.now + 12.days
b2_start = DateTime.now + 1.day
b2_end = DateTime.now + 2.days

booking_one = Booking.create(
                rental_id: rental_one.id,
                start_at: b1_start,
                end_at: b1_end,
                client_email: 'client1@email.com',
                price: rental_one.daily_rate * (b1_end - b1_start)
              )

booking_two = Booking.create(
                rental_id: rental_two.id,
                start_at: b2_start,
                end_at: b2_end,
                client_email: 'client2@email.com',
                price: rental_two.daily_rate * (b2_end - b2_start)
              )
