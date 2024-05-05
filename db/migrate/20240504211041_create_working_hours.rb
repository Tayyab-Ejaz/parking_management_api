class CreateWorkingHours < ActiveRecord::Migration[7.1]
  def change
    create_table :working_hours do |t|
      t.references :parking_slot, null: false, foreign_key: true
      t.integer :day, null: false
      t.boolean :closed
      t.time :start_time, default: "2000-01-01T18:00:00.000Z"
      t.time :end_time, default: "2000-01-01T18:00:00.000Z"

      t.timestamps
    end

    add_index :working_hours, [:parking_slot_id, :day ], unique: true
  end
end
