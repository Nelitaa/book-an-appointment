class Api::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[destroy]

  def index
    @reservations = Reservation.includes(:doctor).all
    render json: { reservations: @reservations }
  end

  def destroy
    if @reservation.destroy
      render json: { message: 'Reservation was successfully destroyed!' }, status: :ok
    else
      render json: { error: 'Failed to delete reservation' }, status: :unprocessable_entity
    end
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
