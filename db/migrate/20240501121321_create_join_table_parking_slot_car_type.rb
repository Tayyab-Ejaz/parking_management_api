class CreateJoinTableParkingSlotCarType < ActiveRecord::Migration[7.1]
  def change
    create_join_table :parking_slots, :car_types do |t|
      # t.index [:parking_slot_id, :car_type_id]
      # t.index [:car_type_id, :parking_slot_id]
    end
  end
end
