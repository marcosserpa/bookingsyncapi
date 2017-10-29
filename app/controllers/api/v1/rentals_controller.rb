module Api
  module V1
    class RentalsController < ApplicationController
      def index
        rentals = Rental.all

        if rentals
          render json: Rental.all, status: 200
        else
          render json: { message: 'There was an internal error' }, status: 500
        end
      end

      def create
        rental = Rental.new(rental_params)

        if rental.save
          render json: @errors, status: :created
        else
          render json: @rental.errors, status: :unprocessable_entity
        end
      end

      def update
        rental = Rental.find params[:id]

        if rental.update(rental_params)
          render json: @errors, status: 204
        else
          render json: { message: "Errors occured when trying to update rental" }, status: :unprocessable_entity
        end
      end

      def destroy
        rental = Rental.find params[:id]

        if rental
          rental.destroy

          render nothing: true, status: 204
        else
          render json: { message: 'Not Found' }, status: 404
        end
      end

      private

      def rental_params
        params.require(:rental).permit(:name, :daily_rate)
      end
    end
  end
end
