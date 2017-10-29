require 'spec_helper'
require 'byebug'

describe Booking do
  let(:rental) { FactoryGirl.create(:rental_one) }
  let(:booking_one) { FactoryGirl.create(:booking_one) }

  context 'should not be created' do
    let!(:booking) { FactoryGirl.create(:booking_one) }

    it 'when check in date is not filled' do
      booking = Booking.create(end_at: DateTime.now, client_email: 'email@email.com', price: 10.0)

      expect(booking.persisted?).to be false
      expect(booking.errors[:start_at]).to match_array ['Check in date need to be filled']
    end

    it 'when check out date is not filled' do
      booking = Booking.create(start_at: DateTime.now, client_email: 'email@email.com', price: 10.0)

      expect(booking.persisted?).to be false
      expect(booking.errors[:end_at]).to match_array ['Check out date need to be filled']
    end

    it 'when client email is not informed' do
      booking = Booking.create(start_at: DateTime.now, end_at: DateTime.now, price: 10.0)

      expect(booking.persisted?).to be false
      expect(booking.errors[:client_email]).to match_array ['Client email needs to be registered']
    end

    it 'when total price is not calculated and stored' do
      booking = Booking.create(start_at: DateTime.now, end_at: DateTime.now, client_email: 'email@email.com')

      expect(booking.persisted?).to be false
      expect(booking.errors[:price]).to match_array ['Total price needs to be registered']
    end

    it 'when it does not have a rental' do
      booking = Booking.new(
                  start_at: DateTime.now,
                  end_at: DateTime.now,
                  client_email: 'email@email.com',
                  price:  10.0
                )

      expect{ booking.save }.to raise_error ActiveRecord::StatementInvalid
    end

    it 'when it has date overlap with another registered booking' do
      booking_one = Booking.create(
                      rental: rental,
                      start_at: DateTime.now + 1.day,
                      end_at: DateTime.now + 4.day,
                      client_email: 'me@email.com',
                      price:  20.0
                    )

      expect(booking.save).to be false
      expect(booking.errors[:dates]).to match_array ["informed cannot overlap existent dates to it's rental"]
    end
  end

  context 'should be created' do
    it 'when all needed infos are filled' do
      booking = Booking.create(
                  rental: rental,
                  start_at: DateTime.now,
                  end_at: DateTime.now,
                  client_email: 'email@email.com',
                  price:  10.0
                )

      expect(booking.persisted?).to be true
    end
  end
end
