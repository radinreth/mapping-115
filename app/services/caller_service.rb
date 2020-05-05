require 'rest-client'

class CallerService
  def self.run(phone_number)
    helper = Rails.application.routes.url_helpers
    phone_number = phone_number.sub(/^0?/, '855')

    begin
      # get payload from external service
      uri = "#{ENV['TELCO_URL']}/#{phone_number}?token=#{ENV['TOKEN']}"
      response = RestClient.get uri, open_timeout: 3

      # save end-result to mapping-115
      RestClient.post helper.api_callers_url(host: 'web'), response, accept: :json, content_type: :json
    rescue StandardError => e
      Rails.logger.debug "CallerService Request failed: #{e.message} #{phone_number}"
    end
  end
end
