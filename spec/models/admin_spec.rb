require 'rails_helper'

RSpec.describe Admin, type: :model do
  it { is_expected.to have_attribute(:email) }
  it { is_expected.to have_attribute(:encrypted_password) }
end
