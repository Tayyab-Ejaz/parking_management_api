class CreateParkingSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :parking_slots do |t|
      t.text :description, null: true
      t.boolean :for_disabled_only, default: false
      t.boolean :has_shade, default: true
      t.boolean :is_available, default: true
      t.decimal :price_per_hour, default: 0
      t.datetime :availability_time_start, default: '1970-01-01 00:00:00'
      t.datetime :availability_time_end, default: '1970-01-01 23:59:00'
      t.integer :cancel_fee_in_percentage, default: 50
      t.string :cancellation_window_in_minutes, default: 60

      t.timestamps
    end
  end
end
