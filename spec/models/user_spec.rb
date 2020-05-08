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

  describe 'associations' do
    it { is_expected.to belong_to(:location) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to validate_presence_of(:ncdd_code) }

    describe ':call_id' do
      let(:location) { create(:location) }
      before do
        create(:user, location: location, call_id: 123)
      end

      it 'raises error' do
        expect { create(:user, location: location, call_id: 123) }.to raise_error(/taken/)
      end
    end
  end
end
