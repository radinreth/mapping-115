helper = Rails.application.routes.url_helpers

puts 'Clear users...'
User.destroy_all

puts 'reset counter...'
Location.where('callers_count > 0').find_each do |loc|
  Location.reset_counters(loc.code, :callers_count)
end

callers = [
  { data: { Location: { LastDate: '2020/01/24', LastLocalTime: '01:17:30',
                        Latitude: 11.45518, Longitude: 104.96388,
                        NCDD_Code: '01020211' },
            phone_number: '85534555132' } },
  { data: { Location: { LastDate: '2020/03/12', LastLocalTime: '08:22:30',
                        Latitude: 11.35508, Longitude: 104.95418,
                        NCDD_Code: '03010101' },
            phone_number: '85539553423' } },
  { data: { Location: { LastDate: '2020/04/02', LastLocalTime: '14:01:30',
                        Latitude: 11.45778, Longitude: 104.14488,
                        NCDD_Code: '02120104' },
            phone_number: '85593555219' } },
  { data: { Location: { LastDate: '2020/04/22', LastLocalTime: '17:11:34',
                        Latitude: 11.45468, Longitude: 104.954822,
                        NCDD_Code: '03020104' },
            phone_number: '85593551190' } },
  { data: { Location: { LastDate: '2020/02/21', LastLocalTime: '18:12:30',
                        Latitude: 11.45008, Longitude: 104.99888,
                        NCDD_Code: '17140406' },
            phone_number: '85593241226' } },
  { data: { Location: { LastDate: '2020/02/22', LastLocalTime: '18:34:30',
                        Latitude: 11.41508, Longitude: 104.55488,
                        NCDD_Code: '06031003' },
            phone_number: '85593555228' } },
  { data: { Location: { LastDate: '2020/04/20', LastLocalTime: '18:06:30',
                        Latitude: 11.43508, Longitude: 104.24488,
                        NCDD_Code: '15060502' },
            phone_number: '85593222112' } },

  { data: { Location: { LastDate: '2020/03/26', LastLocalTime: '18:12:23',
                        Latitude: 11.45523, Longitude: 104.92388,
                        NCDD_Code: '18050202' },
            phone_number: '85593554002' } },
  { data: { Location: { LastDate: '2020/03/25', LastLocalTime: '20:12:30',
                        Latitude: 11.11508, Longitude: 104.95008,
                        NCDD_Code: '19010404' },
            phone_number: '85593987112' } },
  { data: { Location: { LastDate: '2020/04/05', LastLocalTime: '05:34:30',
                        Latitude: 11.454508, Longitude: 104.195488,
                        NCDD_Code: '16010104' },
            phone_number: '85593555212' } },

  { data: { Location: { LastDate: '2020/03/01', LastLocalTime: '21:12:30',
                        Latitude: 11.425508, Longitude: 104.295488,
                        NCDD_Code: '16040203' },
            phone_number: '85593387112' } },
  { data: { Location: { LastDate: '2020/04/05', LastLocalTime: '08:22:30',
                        Latitude: 11.452508, Longitude: 104.953488,
                        NCDD_Code: '03080810' },
            phone_number: '85593512112' } },
  { data: { Location: { LastDate: '2020/04/15', LastLocalTime: '18:45:30',
                        Latitude: 11.4522508, Longitude: 104.9548238,
                        NCDD_Code: '09050101' },
            phone_number: '85593512112' } },
  { data: { Location: { LastDate: '2020/04/17', LastLocalTime: '17:12:30',
                        Latitude: 11.455408, Longitude: 104.954288,
                        NCDD_Code: '01020201' },
            phone_number: '85592511112' } },
  { data: { Location: { LastDate: '2020/03/29', LastLocalTime: '15:12:30',
                        Latitude: 11.45098, Longitude: 104.91488,
                        NCDD_Code: '07030901' },
            phone_number: '85593522112' } },
  { data: { Location: { LastDate: '2020/04/12', LastLocalTime: '18:22:31',
                        Latitude: 11.451508, Longitude: 104.951488,
                        NCDD_Code: '08070907' },
            phone_number: '855935833412' } },
  { data: { Location: { LastDate: '2020/04/23', LastLocalTime: '22:12:30',
                        Latitude: 11.445508, Longitude: 104.953488,
                        NCDD_Code: '16010301' },
            phone_number: '85593500112' } },
  { data: { Location: { LastDate: '2020/04/19', LastLocalTime: '14:12:50',
                        Latitude: 11.455028, Longitude: 104.954388,
                        NCDD_Code: '20020314' },
            phone_number: '855969855112' } },
  { data: { Location: { LastDate: '2020/04/03', LastLocalTime: '18:12:30',
                        Latitude: 12.45508, Longitude: 103.95488,
                        NCDD_Code: '15010215' },
            phone_number: '85589365112' } },
  { data: { Location: { LastDate: '2020/04/08', LastLocalTime: '14:15:30',
                        Latitude: 11.455208, Longitude: 104.954884,
                        NCDD_Code: '24020113' },
            phone_number: '85596552112' } },
  { data: { Location: { LastDate: '2020/04/11', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '23010104' },
            phone_number: '85595551112' } },
  { data: { Location: { LastDate: '2020/04/14', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '17110203' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/24', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '18050202' },
            phone_number: '85593115112' } },
  { data: { Location: { LastDate: '2020/04/21', LastLocalTime: '18:12:30',
                        Latitude: 11.451508, Longitude: 104.95488,
                        NCDD_Code: '15010401' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/19', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '12011203' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/04', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '01080804' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/11', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '04020303' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/16', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '11040202' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/17', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '17110408' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/20', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '06010106' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/16', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '16070105' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/03', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '03010805' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/13', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '05030107' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/26', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '25020504' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/26', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '02020901' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/25', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '07071204' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/17', LastLocalTime: '18:12:30',
                        Latitude: 11.145508, Longitude: 104.95488,
                        NCDD_Code: '11020303' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/12', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '02140505' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/03/26', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '09010204' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/11', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '10010803' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/15', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '16010303' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/14', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '21010605' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/18', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '10021102' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/21', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '21010202' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/09', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '07010304' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/03/30', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '08020606' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/15', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '13020204' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/20', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '15010207' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/17', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '06010205' },
            phone_number: '85593555112' } },
  { data: { Location: { LastDate: '2020/04/23', LastLocalTime: '18:12:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '19010403' },
            phone_number: '85593555112' } }
]

callers = [
  { data: { Location: { LastDate: '2020/04/26', LastLocalTime: '18:17:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '081104' },
            phone_number: '85593555225' } },
  { data: { Location: { LastDate: '2020/04/25', LastLocalTime: '18:17:30',
                        Latitude: 11.45508, Longitude: 104.95488,
                        NCDD_Code: '081104' },
            phone_number: '85510666557' } }
]

# callers = []

url = helper.api_callers_url(host: 'web:3000')

puts 'setup callers...'
callers.each do |caller|
  response = RestClient.post url, caller, accept: :json, content_type: :json
  if response.code == '500'
    puts response.msg, request.body
    break
  end
end
puts 'done'
