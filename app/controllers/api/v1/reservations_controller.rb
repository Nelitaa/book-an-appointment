class Api::V1::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.includes(:doctor).all
    render json: { reservations: @reservations }
  end
end
