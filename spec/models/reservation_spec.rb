require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject do
    @user = User.create(email: 'ex6@gmail.com', password: '123456')
    @doctor = Doctor.create(name: 'Juan Muñoz', specialization: 'Pediatry', city: 'Miami', fee: 200,
                            photo: 'https://st2.depositphotos.com/1743476/5738/i/950/depositphotos_57385697-stock-photo-confident-mature-doctor.jpg',
                            experience: 20)
    @reservation = Reservation.create(user_id: @user.id, doctor_id: @doctor.id, date: '2023-04-10', city: 'Miami')
  end

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(@reservation).to be_valid
  end

  it 'is not valid without a user_id' do
    @reservation.user_id = nil
    expect(@reservation).to_not be_valid
  end

  it 'is not valid without a doctor_id' do
    @reservation.doctor_id = nil
    expect(@reservation).to_not be_valid
  end

  it 'is not valid without a date' do
    @reservation.date = nil
    expect(@reservation).to_not be_valid
  end

  it 'is not valid without a city' do
    @reservation.city = nil
    expect(@reservation).to_not be_valid
  end
end
