class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :flat, null: false, foreign_key: true
      t.boolean :liked, default: false

      t.timestamps
    end
  end
end
