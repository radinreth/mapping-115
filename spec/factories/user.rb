FactoryBot.define do
  factory :user do
    phone_number { '85593555225' }
    ncdd_code { '081104' }
    lat { 11 }
    lng { 104 }
    last_datetime { 1.day.from_now }
  end
end
