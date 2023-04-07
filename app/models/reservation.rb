class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  validates :date, presence: true
  validates :time, presence: true
end
