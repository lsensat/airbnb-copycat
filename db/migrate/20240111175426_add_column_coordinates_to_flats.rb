class AddColumnCoordinatesToFlats < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :latitude, :float
    add_column :flats, :longitude, :float
  end
end
