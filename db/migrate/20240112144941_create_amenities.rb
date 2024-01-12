class CreateAmenities < ActiveRecord::Migration[7.1]
  def change
    create_table :amenities do |t|
      t.references :flat, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end