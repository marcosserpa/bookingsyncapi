require 'spec_helper'

describe Api::V1::BookingsController, type: :request do
  describe 'GET/bookings' do
    let!(:booking_one) { FactoryGirl.create(:booking_one) }
    let!(:booking_two) { FactoryGirl.create(:booking_two) }

    context 'when the request is valid' do
      before do
        get api_v1_bookings_path
      end

      it 'returns all bookings' do
        body = JSON.parse(response.body)
        bookings_names = body.map{ |booking| booking['price'] }

        expect(response.status).to eql 200
        expect(bookings_names).to match_array [booking_one.price, booking_two.price]
      end
    end
  end

  describe 'POST/booking' do
    let!(:rental) { FactoryGirl.create(:rental) }

    context "when all data is valid" do
      before do
        booking_params = {
          booking: {
            start_at: DateTime.now + 1.month,
            end_at: DateTime.now + 2.months,
            client_email: 'post_email@email.com',
            price: 10.0,
            rental_id: rental.id
          }
        }
        request_headers = { 'Accept' => 'application/json' }

        post api_v1_bookings_path, booking_params, request_headers
      end

      it 'booking should be created' do
        expect(response.status).to eql 201
        expect(Booking.last.client_email).to eql 'post_email@email.com'
      end
    end
  end

  describe 'PUT/bookings/:id' do
    let!(:booking_one) { FactoryGirl.create(
                          :booking_one,
                          start_at: DateTime.now + 3.months,
                          end_at: DateTime.now + 4.months
                         )
                       }

    context "when request a booking update with it's permitted fields" do
      before do
        booking_params = {
          booking: {
            price: 18.90
          }
        }

        request_headers = { 'Accept' => 'application/json' }

        put api_v1_booking_path(id: booking_one.id), booking_params, request_headers
      end

      it 'booking should be update' do
        expect(response.status).to eql 204

        expect(Booking.last.price).to eql 18.90
      end
    end
  end

  describe 'DELETE/bookings/:id' do
    let!(:booking_two) { FactoryGirl.create(:booking_two) }
    let!(:all_bookings_ids) { Booking.all.map &:id }

    context 'when request a with a valid ID' do
      before do
        request_headers = {
          'Accept' => 'application/json'
        }

        delete api_v1_booking_path(id: booking_two.id), {}, request_headers
      end

      it "should delete the booking" do
        expect(response.status).to eql 204
        expect(all_bookings_ids - Booking.all.map(&:id)).to eql [booking_two.id]
      end
    end
  end
end
