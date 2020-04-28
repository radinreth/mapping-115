require 'rest-client'

class CallerService
  def self.run(phone_number)
    # get payload from external service
    uri = "#{ENV['TELCO_URL']}/#{phone_number}?token=#{ENV['TOKEN']}"
    response = RestClient.get uri

    # save end-result to mapping-115
    RestClient.post api_callers_path, response
  end
end
