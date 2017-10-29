require 'spec_helper'

describe Api::V1::RentalsController, type: :request do
  describe 'GET/rentals' do
    let!(:rental_one) { FactoryGirl.create(:rental_one) }
    let!(:rental_two) { FactoryGirl.create(:rental_two) }

    context 'when the request is valid' do
      before do
        get api_v1_rentals_path, { token_auth: 'ABCDE_BookyngSync' }
      end

      it 'returns all rentals' do
        body = JSON.parse(response.body)
        rentals_names = body.map{ |rental| rental['name'] }

        expect(response.status).to eql 200
        expect(rentals_names).to match_array [rental_one.name, rental_two.name]
      end
    end
  end

  describe 'POST/rental' do
    context "when all data is valid" do
      before do
        rental_params = {
          rental: {
            name: 'Rental Test',
            daily_rate: 10.0
          },
          token_auth: 'ABCDE_BookyngSync'
        }
        request_headers = { 'Accept' => 'application/json' }

        post api_v1_rentals_path, rental_params, request_headers
      end

      it 'rental should be created' do
        expect(response.status).to eql 201
        expect(Rental.last.name).to eql 'Rental Test'
      end
    end
  end

  describe 'PUT/rentals/:id' do
    let!(:rental_one) { FactoryGirl.create(:rental_one) }

    context "when request a rental update with it's permitted fields" do
      before do
        rental_params = {
          rental: {
            name: 'New Name 2'
          },
          token_auth: 'ABCDE_BookyngSync'
        }

        request_headers = { 'Accept' => 'application/json' }

        put api_v1_rental_path(id: rental_one.id), rental_params, request_headers
      end

      it 'rental should be update' do
        expect(response.status).to eql 204
        expect(Rental.last.name).to eql 'New Name 2'
      end
    end
  end

  describe 'DELETE/rentals/:id' do
    let!(:rental_two) { FactoryGirl.create(:rental_two) }
    let!(:all_rentals_ids) { Rental.all.map &:id }
    let!(:booking) { FactoryGirl.create(:booking_one, rental: rental_two) }

    context 'when request a with a valid ID' do
      before do
        request_headers = {
          'Accept' => 'application/json'
        }

        delete api_v1_rental_path(id: rental_two.id), { token_auth: 'ABCDE_BookyngSync' }, request_headers
      end

      it 'should delete the rental' do
        expect(response.status).to eql 204
        expect(all_rentals_ids - Rental.all.map(&:id)).to eql [rental_two.id]
      end

      it "should also remove all it's dependent bookings" do
        expect{ Booking.find(booking.id) }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
