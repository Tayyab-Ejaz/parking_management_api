class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :parking_slot

  enum status: {
    confirmed: 0,
    cancelled: 1,
    checked_in: 2,
    checked_out: 3
  }
end
