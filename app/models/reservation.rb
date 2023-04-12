class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  validates :date, presence: true
  validates :time, presence: true
  validates :city, presence: true
  validate :user_and_doctor_exist

  private

  def user_and_doctor_exist
    unless User.exists?(self.user_id)
      errors.add(:user_id, "does not exist")
    end

    unless Doctor.exists?(self.doctor_id)
      errors.add(:doctor_id, "does not exist")
    end
  end
end
