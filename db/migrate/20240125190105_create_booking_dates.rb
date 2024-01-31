class CreateBookingDates < ActiveRecord::Migration[7.1]
  def change
    create_table :booking_dates do |t|
      t.references :booking, null: false, foreign_key: true
      t.date :date
      t.integer :price

      add_foreign_key :booking_dates, :bookings, on_delete: :cascade

      t.timestamps
    end
  end
end
