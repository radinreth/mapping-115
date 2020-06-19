class LocationDecorator
  def initialize(options={})
    @parent_id = options[:parent_id]
    @parent_kind = Location.location_kind(@parent_id)
    @child_kind  = child_kinds[@parent_kind]
  end

  def provinces
    locations = Location.where(kind: 'province')
    group_data = User.group(:province_id).count

    format_data(locations, group_data)
  end

  def get_data
    return [] unless @child_kind.present?

    locations = Location.where(location_params)
    group_data = User.where(user_params).group("#{@child_kind}_id".to_sym).count

    format_data(locations, group_data)
  end

  private
    def child_kinds
      { 'province' => 'district', 'district' => 'commune' }
    end

    def format_data(locations, group_data)
      jsonData = locations.as_json
      jsonData.each_with_index do |location, index|
        location['callers_count'] = group_data[location['code']]
        location['text'] = "#{location['code']}. #{location['name_km']} (#{location['callers_count']})"
        location['children'] = @child_kind == 'commune' ? false : locations[index].children.present?
        location['id'] = location['code']
        location['icon'] = ActionController::Base.helpers.image_url(icon)
      end

      jsonData
    end

    def location_params
      { parent_id: @parent_id, kind: @child_kind }
    end

    def icon
      return icons['province'] if @parent_id.nil?

      icons[@child_kind]
    end

    def icons
      { 'province' => 'phd.png', 'district' => 'od.png', 'commune' => 'hc.png' }
    end

    def user_params
      params = {}
      params["#{@parent_kind}_id".to_sym] = @parent_id
      params
    end
end
