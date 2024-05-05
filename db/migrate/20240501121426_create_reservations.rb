class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :parking_slot, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status, default: 0
      t.datetime :checkin_time, null: true
      t.datetime :checkout_time, null: true

      t.timestamps
    end
  end
end
