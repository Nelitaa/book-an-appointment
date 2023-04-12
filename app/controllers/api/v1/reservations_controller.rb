class Api::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[destroy]

  def index
    @reservations = Reservation.includes(:doctor).all
    render json: { reservations: @reservations }
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: { reservation: @reservation, success: true, message: "Doctor's appointment created successfully!" }, status: :created
    else
      render json: { message: @reservation.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    if @reservation.destroy
      render json: { reservation: @reservation, success: true, message: 'Reservation was successfully destroyed!' }, status: :ok
    else
      render json: { error: 'Failed to delete reservation' }, status: :unprocessable_entity
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:doctor_id, :date, :city, :user_id)
  end
end
