module ApplicationHelper
  def normalize_params(hash, result = {})
    hash.keys.each do |key|
      if hash[key].is_a? ActionController::Parameters
        result = normalize_params(hash[key], result)
      else
        result[mapper[key]] = hash[key]
      end
    end
    result
  end

  def mapper
    @mapper ||= { phone_number: 'phone_number', Latitude: 'lat', Longitude: 'lng', NCDD_Code: 'ncdd_code' }
    @mapper.with_indifferent_access
  end
end
