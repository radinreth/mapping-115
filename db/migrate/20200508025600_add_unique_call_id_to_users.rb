class AddUniqueCallIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :call_id, :integer
    add_index :users, :call_id, unique: true
  end
end
