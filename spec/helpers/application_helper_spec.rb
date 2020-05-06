require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'normalize params to match model attributes' do
    loc_params = {
      'LastDate': '2020/04/26',
      'LastLocalTime': '18:17:30',
      'Latitude': '11.45508',
      'Longitude': '104.95488',
      'NCDD_Code': '19010403'
    }

    hash = {
      'last_datetime': '2020/04/26 18:17:30',
      'phone_number': '85593555112',
      'Location': ActionController::Parameters.new(loc_params)
    }

    expect(helper.normalize_params(hash)).to include(
      'phone_number' => '85593555112',
      'last_datetime' => '2020/04/26 18:17:30',
      'lat' => '11.45508',
      'lng' => '104.95488',
      'ncdd_code' => '19010403'
    )
  end

  it 'return model mapping attribute' do
    expect(helper.mapper).to include({
                                       Latitude: 'lat',
                                       Longitude: 'lng',
                                       NCDD_Code: 'ncdd_code',
                                       phone_number: 'phone_number'
                                     })
  end
end
