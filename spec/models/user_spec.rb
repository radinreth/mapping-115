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
require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_attribute(:phone_number) }
  it { is_expected.to have_attribute(:lat) }
  it { is_expected.to have_attribute(:lng) }
  it { is_expected.to have_attribute(:last_datetime) }
  it { is_expected.to have_attribute(:ncdd_code) }

  describe "associations" do
    it { is_expected.to belong_to(:location) }
  end
end
