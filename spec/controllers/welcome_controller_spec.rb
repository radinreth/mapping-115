require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  include_context :gon

  context 'NOT admin_signed_in?' do
    it 'return empty locations' do
      get :index
      expect(gon['locations']).to eq []
    end
  end

  context 'admin_signed_in?' do
    let(:user) { build(:user, last_datetime: Date.current.strftime('%Y/%m/%d')) }
    let(:admin) { create(:admin) }

    before { create(:location, code: '081104', callers: [user]) }

    it 'return locations' do
      sign_in admin

      get :index

      expect(gon['locations'].count).to eq 1
      expect(gon['locations'][0]).to include({
        'code' => user.location_id,
        'callers_count' => 1,
        'lat' => user.lat,
        'lng' => user.lng
      })
    end
  end
end
