class CarType < ApplicationRecord
    validates :name, uniqueness: true
    has_and_belongs_to_many :parking_slots
end
