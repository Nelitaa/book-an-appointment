class Api::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[destroy update]
  before_action :authenticate_user!

  def index
    @reservations = Reservation.includes(:doctor).all
    render json: { reservations: @reservations }
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      render json: { reservation: @reservation, success: true, message: "Doctor's appointment created successfully!" }, status: :created
    else
      render json: { message: @reservation.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    if @reservation.destroy
      render json: { reservation: @reservation, success: true, message: "Doctor's appointment was successfully destroyed!" }, status: :ok
    else
      render json: { error: "Failed to delete Doctor's appointment" }, status: :unprocessable_entity
    end
  end

  def update
    if @reservation.update(reservation_params)
      render json: { reservation: @reservation, success: true, message: "Doctor's appointment was successfully updated!" }, status: :ok
    else
      render json: { error: "Failed to update Doctor's appointment" }, status: :unprocessable_entity
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:doctor_id, :date, :city)
  end
end
