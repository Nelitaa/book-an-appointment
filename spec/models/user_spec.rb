require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    @user = User.create(email: "ex6@gmail.com", password: "123456")
  end

  before { subject.save }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a password less than 6 characters" do
    subject.password = "12345"
    expect(subject).to_not be_valid
  end

  it "is not valid with a password more than 20 characters" do
    subject.password = "123456789012345678901"
    expect(subject).to_not be_valid
  end
end
