class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :phone_number, null: false
      t.float :lat
      t.float :lng
      t.datetime :last_datetime
      t.string :ncdd_code, null: false
      t.string :location_id, column: :code, index: true

      t.timestamps
    end
  end
end
