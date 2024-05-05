class ParkingSlot < ApplicationRecord
    has_and_belongs_to_many :car_types
    has_many :reservations
    has_many :working_hours, dependent: :destroy

    accepts_nested_attributes_for :working_hours

    validates :price_per_hour, numericality: { greater_than_or_equal_to: 0 }
    validates :availability_time_start, presence: true
    validates :availability_time_end, presence: true
    validate :availability_times_valid

    def availability_times_valid
        if availability_time_start >= availability_time_end
            errors.add(:availability_time_start, 'must be earlier than availability_time_end')
        end
    end

    after_create :initialize_default_working_hours

    def initialize_default_working_hours
        days_of_week = {
          1 => { start_time: '00:00', end_time: '23:00', closed: false },
          2 => { start_time: '00:00', end_time: '23:00', closed: false },
          3 => { start_time: '00:00', end_time: '23:00', closed: false },
          4 => { start_time: '00:00', end_time: '23:00', closed: false },
          5 => { start_time: '00:00', end_time: '23:00', closed: false },
          6 => { start_time: '00:00', end_time: '23:00', closed: true },
          0 => { start_time: '00:00', end_time: '23:00', closed: true }
        }
    
        days_of_week.each do |day, hours|
          working_hours.create(day: day, closed: hours&.fetch(:closed), start_time: hours&.fetch(:start_time), end_time: hours&.fetch(:end_time))
        end
      end
end
