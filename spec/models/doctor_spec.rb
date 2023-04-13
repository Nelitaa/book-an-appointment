require 'rails_helper'

RSpec.describe Doctor, type: :model do
  subject do
    @user = User.create(email: "ex6@gmail.com", password: "123456")
    @doctor = Doctor.create(name: "Juan Muñoz", specialization: "Pediatry", city: "Miami", fee: 200, photo: "https://st2.depositphotos.com/1743476/5738/i/950/depositphotos_57385697-stock-photo-confident-mature-doctor.jpg", experience: 20)
  end

  before { subject.save }

  it "is valid with valid attributes" do
    expect(@doctor).to be_valid
  end

  it "is not valid without a name" do
    @doctor.name = nil
    expect(@doctor).to_not be_valid
  end

  it "is not valid without a specialization" do
    @doctor.specialization = nil
    expect(@doctor).to_not be_valid
  end

  it "is not valid without a city" do
    @doctor.city = nil
    expect(@doctor).to_not be_valid
  end

  it "is not valid without a fee" do
    @doctor.fee = nil
    expect(@doctor).to_not be_valid
  end

  it "is not valid without a photo" do
    @doctor.photo = nil
    expect(@doctor).to_not be_valid
  end

  it "is not valid without a experience" do
    @doctor.experience = nil
    expect(@doctor).to_not be_valid
  end

  it "is not valid with a fee less than 1" do
    @doctor.fee = 0
    expect(@doctor).to_not be_valid
  end

  it "is not valid with a experience less than 1" do
    @doctor.experience = 0
    expect(@doctor).to_not be_valid
  end
end
