class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  validates :date, presence: true
  validates :city, presence: true
  validate :user_and_doctor_exist

  private

  def user_and_doctor_exist
    errors.add(:user_id, 'does not exist') unless User.exists?(user_id)

    return if Doctor.exists?(doctor_id)

    errors.add(:doctor_id, 'does not exist')
  end
end
