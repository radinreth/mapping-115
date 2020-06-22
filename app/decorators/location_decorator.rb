class LocationDecorator
  def initialize(options={})
    @parent_id = options[:parent_id]
    @parent_kind = Location.location_kind(@parent_id)
    @child_kind  = child_kinds[@parent_kind]
    @start_date = options[:start_date]
    @end_date = options[:end_date]
  end

  def data
    locations = Location.where(location_params)
    group_data = User.where('date(last_datetime) >= ? AND date(last_datetime) <= ?', @start_date, @end_date).where(user_params).group(group_field).count

    format_data(locations, group_data)
  end

  private
    def child_kinds
      { 'province' => 'district', 'district' => 'commune' }
    end

    def format_data(locations, group_data)
      jsonData = locations.as_json
      jsonData.each_with_index do |location, index|
        location['callers_count'] = group_data[location['code']].to_i
        location['text'] = "#{location['code']}. #{location['name_km']} (#{location['callers_count']})"
        location['children'] = @child_kind == 'commune' ? false : locations[index].children.present?
        location['id'] = location['code']
        location['icon'] = ActionController::Base.helpers.image_url(icon)
      end

      jsonData
    end

    def location_params
      return { kind: 'province' } if province?

      { parent_id: @parent_id, kind: @child_kind }
    end

    def icon
      return icons['province'] if province?

      icons[@child_kind]
    end

    def icons
      { 'province' => 'phd.png', 'district' => 'od.png', 'commune' => 'hc.png' }
    end

    def province?
      return @parent_id.blank? || @parent_id == '#'
    end

    def user_params
      return {} if province?

      params = {}
      params["#{@parent_kind}_id".to_sym] = @parent_id
      params
    end

    def group_field
      return :province_id if province?

      "#{@child_kind}_id".to_sym
    end
end
