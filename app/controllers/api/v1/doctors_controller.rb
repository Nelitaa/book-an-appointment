class Api::V1::DoctorsController < ApplicationController
   def index
    @doctors = Doctor.all
    render json: @doctors
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      render json: @doctor, status: :created
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  private

  def doctor_params
    params.require(:doctor).permit(:name, :specialization, :city, :fee, :photo, :experience)
  end
end
