module Api
  module V1
    class BookingsController < ApplicationController
      def index
        bookings = Booking.all

        if bookings
          render json: bookings, status: 200
        else
          render json: { message: 'There was an internal error' }, status: 500
        end
      end

      def create
        booking = Booking.new(booking_params)

        if booking.save
          render json: @errors, status: :created
        else
          render json: @booking.errors, status: :unprocessable_entity
        end
      end

      def update
        booking = Booking.find params[:id]

        if booking.update(booking_params)
          render json: @errors, status: 204
        else
          render json: { message: "Errors occured when trying to update booking" }, status: :unprocessable_entity
        end
      end

      def destroy
        booking = Booking.find params[:id]

        if booking
          booking.destroy

          render nothing: true, status: 204
        else
          render json: { message: 'Not Found' }, status: 404
        end
      end

      private

      def booking_params
        params.require(:booking).permit(:start_at, :end_at, :client_email, :price, :rental_id)
      end
    end
  end
end
