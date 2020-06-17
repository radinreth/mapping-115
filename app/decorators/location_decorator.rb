class LocationDecorator
  def initialize(options={})
    @province_id = options[:province_id]
    @district_id = options[:district_id]
    @commune_id = options[:commune_id]
  end

  def provinces
    locations = Location.where(kind: 'province')
    group_data = User.group(:province_id).count

    format_data(locations, group_data)
  end

  def districts
    locations = Location.where(parent_id: @province_id, kind: 'district')
    group_data = User.where(province_id: @province_id).group(:district_id).count

    format_data(locations, group_data)
  end

  def communes
    locations = Location.where(parent_id: @district_id, kind: 'district')
    group_data = User.where(district_id: @district_id).group(:commune_id).count

    format_data(locations, group_data)
  end

  private
    def format_data(locations, group_data)
      locations.each do |location|
        location.callers_count = group_data[location.code]
      end

      locations
    end
end
