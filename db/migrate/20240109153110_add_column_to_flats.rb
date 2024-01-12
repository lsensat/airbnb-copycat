class AddColumnToFlats < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :zip, :integer, null: false
    add_column :flats, :city, :string, null: false
    add_column :flats, :country, :string, null: false
    remove_column :flats, :location, :string
    add_column :flats, :address, :string, null: false
    add_column :flats, :checkin, :time, null: true, default: '08:00:00'
    add_column :flats, :checkout, :time, null: true, default: '22:00:00'
  end
end
