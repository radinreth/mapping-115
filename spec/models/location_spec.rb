# == Schema Information
#
# Table name: locations
#
#  code          :string           not null, primary key
#  name_en       :string           not null
#  name_km       :string           not null
#  kind          :string           not null
#  parent_id     :string
#  lat           :float
#  lng           :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  callers_count :integer          default("0")
#
require 'rails_helper'

RSpec.describe Location, type: :model do
  it { is_expected.to have_attribute(:code) }
  it { is_expected.to have_attribute(:name_en) }
  it { is_expected.to have_attribute(:name_km) }
  it { is_expected.to have_attribute(:kind) }
  it { is_expected.to have_attribute(:lat) }
  it { is_expected.to have_attribute(:lng) }
  it { is_expected.to belong_to(:parent).optional }
end
