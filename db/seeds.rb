require 'uri'
require 'net/http'

User.destroy_all

callers = [
  { data: { Location: { Latitude: 11.45508, Longitude: 104.95488, NCDD_Code: '01020111' }, 
            phone_number: '85534555222' } },
  { data: { Location: { Latitude: 11.45508, Longitude: 104.95488, NCDD_Code: '03010707' }, 
            phone_number: '85539555223' } },
  { data: { Location: { Latitude: 11.45508, Longitude: 104.95488, NCDD_Code: '021201' }, 
            phone_number: '85593555224' } },
  { data: { Location: { Latitude: 11.45508, Longitude: 104.95488, NCDD_Code: '031401' }, 
            phone_number: '85593555225' } },
  { data: { Location: { Latitude: 11.45508, Longitude: 104.95488, NCDD_Code: '1706' }, 
            phone_number: '85593551226' } },
  { data: { Location: { Latitude: 11.45508, Longitude: 104.95488, NCDD_Code: '0602' }, 
            phone_number: '85593555229' } },
  { data: { Location: { Latitude: 11.45508, Longitude: 104.95488, NCDD_Code: '16' }, 
            phone_number: '85593555112' } }
]

url = URI('http://localhost:3000/api/callers')

http = Net::HTTP.new(url.host, url.port)
request = Net::HTTP::Post.new(url)
request['Content-Type'] = ['application/json', 'text/plain']
request['Accept'] = 'application/json'

callers.each do |caller|
  request.body = caller.to_json
  http.request(request)
end
