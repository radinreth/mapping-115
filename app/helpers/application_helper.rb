module ApplicationHelper
  def normalize_params(hash, result = {})
    last_date = hash.delete('LastDate')
    last_local_time = hash.delete('LastLocalTime')

    hash.keys.each do |key|
      if hash[key].is_a? ActionController::Parameters
        result = normalize_params(hash[key], result)
      else
        result[mapper[key]] = hash[key]
      end
    end

    if last_date && last_local_time
      result['last_datetime'] = "#{last_date} #{last_local_time}"
    end

    result
  end

  def mapper
    @mapper ||= { phone_number: 'phone_number', Latitude: 'lat', Longitude: 'lng', NCDD_Code: 'ncdd_code' }
    @mapper.with_indifferent_access
  end
end
