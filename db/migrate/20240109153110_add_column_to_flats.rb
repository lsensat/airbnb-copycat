class AddColumnToFlats < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :zip, :integer, null: false
    add_column :flats, :city, :string, null: false
    add_column :flats, :country, :string, null: false
    remove_column :flats, :location, :string
    add_column :flats, :address, :string, null: false
    add_column :flats, :checkin, :time, null: true
    add_column :flats, :checkout, :time, null: true
  end
end
