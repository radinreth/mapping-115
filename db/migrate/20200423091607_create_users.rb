class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :phone_number, null: false
      t.float :lat
      t.float :lng
      t.string :ncdd_code, null: false
      t.belongs_to :location

      t.timestamps
    end
  end
end
