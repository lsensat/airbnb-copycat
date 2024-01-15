class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :flat, null: false, foreign_key: true
      t.integer :total_price
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
