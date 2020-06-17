require 'rake'

class AddProvinceIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :province_id, :string
    add_column :users, :district_id, :string
    add_column :users, :commune_id, :string

    Rake::Task['user:migrate_locations'].invoke
  end
end
