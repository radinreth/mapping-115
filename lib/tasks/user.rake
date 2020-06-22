# frozen_string_literal: true

namespace :user do
  desc 'migrate missing locaiton'
  task migrate_locations: :environment do
    User.find_each do |user|
      location_id = user.location_id
      province_id = location_id.length >= 2 ? location_id[0..1] : nil
      district_id = location_id.length >= 4 ? location_id[0..3] : nil
      commune_id  = location_id.length >= 6 ? location_id[0..5] : nil

      user.update_attributes(province_id: province_id, district_id: district_id, commune_id: commune_id)
    end
  end
end
