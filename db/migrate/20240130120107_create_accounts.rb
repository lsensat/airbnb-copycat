class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name, null: true
      t.string :last_name, null: true

      t.timestamps
    end
  end
end
