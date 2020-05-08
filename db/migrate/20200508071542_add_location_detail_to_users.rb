class AddLocationDetailToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :location_detail, :string, default: ''
  end
end
