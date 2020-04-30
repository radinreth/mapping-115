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

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:name_en) }
    it { is_expected.to validate_presence_of(:name_km) }
    it { is_expected.to validate_presence_of(:kind) }
  end

  describe '.location_kind' do
    it 'assumes 2 digits code is `province`' do
      kind = described_class.location_kind('01')
      expect(kind).to eq 'province'
    end

    it 'assumes 4 digits code is `district`' do
      kind = described_class.location_kind('0102')
      expect(kind).to eq 'district'
    end

    it 'assumes 6 digits code is `commune`' do
      kind = described_class.location_kind('010203')
      expect(kind).to eq 'commune'
    end

    it 'assumes 8 digits or more code is `village`' do
      kind = described_class.location_kind('01020304')
      expect(kind).to eq 'village'
    end

    describe '.query' do
      let(:user) { build(:user) }

      describe 'SpotQuery' do
        before do
          create(:location, code: '081104', callers: [user])
        end

        it "returns user's lat, lng" do
          query = Location.query('spot', Time.current, 2.days.from_now)

          expect(query[0]['lat']).to eq user.lat
          expect(query[0]['lng']).to eq user.lng
        end
      end

      describe 'CommuneQuery' do
        before do
          @commune = create(:location, code: '081104', lat: 11.11, lng: 104.12, callers: [user])
        end

        it "returns commune's lat, lng" do
          query = Location.query('commune', Time.current, 2.days.from_now)

          expect(query[0]['lat']).to eq @commune.lat
          expect(query[0]['lng']).to eq @commune.lng
        end
      end

      describe 'DistrictQuery' do
        before do
          @district = create(:location, code: '0811', lat: 11.11, lng: 104.12, callers: [user])
        end

        it "returns district's lat, lng" do
          query = Location.query('district', Time.current, 2.days.from_now)

          expect(query[0]['lat']).to eq @district.lat
          expect(query[0]['lng']).to eq @district.lng
        end
      end

      describe 'ProvinceQuery' do
        before do
          @province = create(:location, code: '08', lat: 11.11, lng: 104.12, callers: [user])
        end

        it "returns province's lat, lng" do
          query = Location.query('province', Time.current, 2.days.from_now)

          expect(query[0]['lat']).to eq @province.lat
          expect(query[0]['lng']).to eq @province.lng
        end
      end
    end
  end
end
