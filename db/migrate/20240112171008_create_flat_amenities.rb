class CreateFlatAmenities < ActiveRecord::Migration[7.1]
  def change
    create_table :flat_amenities do |t|
      t.references :flat, null: false, foreign_key: true
      t.references :amenity, null: false, foreign_key: true
      # t.boolean :has_amenity, default: false

      t.timestamps
    end
  end
end
