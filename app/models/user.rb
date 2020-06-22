# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  phone_number  :string           not null
#  lat           :float
#  lng           :float
#  last_datetime :datetime
#  ncdd_code     :string           not null
#  location_id   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class User < ApplicationRecord
  belongs_to :location

  validates :phone_number, presence: true
  validates :ncdd_code, presence: true
  validates :call_id, uniqueness: true

  before_create :assign_locations

  private
    def assign_locations
      self.province_id = location_id[0..1] if location_id.length >= 2
      self.district_id = location_id[0..3] if location_id.length >= 4
      self.commune_id  = location_id[0..5] if location_id.length >= 6
    end
end
