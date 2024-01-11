class CreateFlats < ActiveRecord::Migration[7.1]
  def change
    create_table :flats do |t|
      t.string :title
      t.text :description
      t.integer :bedrooms
      t.integer :price
      t.string :location
      t.float :rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
