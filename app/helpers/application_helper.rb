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
    @mapper ||= {
      phone_number: 'phone_number',
      last_datetime: 'last_datetime',
      call_id: 'call_id',
      Detail: 'location_detail',
      Latitude: 'lat',
      Longitude: 'lng',
      NCDD_Code: 'ncdd_code'
    }.with_indifferent_access
  end

  def get_css_active_class(name)
    return 'active' if params['controller'] == name
  end
end
