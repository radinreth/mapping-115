class AddCallersCountToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :callers_count, :integer, default: 0
  end
end
