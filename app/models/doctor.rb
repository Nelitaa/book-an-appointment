class Doctor < ApplicationRecord
  has_many :users, through: :reservations
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, length: {in: 1..50 }
  validates :specialization, presence: true, length: {in: 1..500 }
  validates :city, presence: true, length: {in: 1..50 }
  validates :fee, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :photo, presence: true, length: {in: 1..200 }
  validates :experience, presence: true, numericality: { greater_than_or_equal_to: 1 } 
end
