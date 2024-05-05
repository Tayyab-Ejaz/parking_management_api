class WorkingHour < ApplicationRecord
    belongs_to :parking_slot
    validates :day, inclusion: { in: %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday] }

    enum day: %i[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
end
