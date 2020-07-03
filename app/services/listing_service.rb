require 'fast_excel'

class ListingService
  def initialize(options={})
    @start_date = options[:start_date]
    @end_date = options[:end_date]
  end

  def data
    return @data if @data.present?

    provinces = all_locations.select { |location| location.kind == 'province' }
    @data = format_data(provinces, 'province')
  end

  def export_excel
    workbook = FastExcel.open

    build_all_province_worksheet(workbook)
    build_each_province_worksheet(workbook)

    workbook.read_string
  end

  def build_all_province_worksheet(workbook)
    worksheet = workbook.add_worksheet('Provinces')
    worksheet.append_row(column_headers)

    data.each do |location|
      worksheet.append_row(column_bodies.map {|col| location[col]})
    end
  end

  def build_each_province_worksheet(workbook)
    data.each do |location|
      worksheet = workbook.add_worksheet(location['name_en'])
      worksheet.append_row(column_headers)

      append_to_sheet(worksheet, [location])
    end
  end

  def append_to_sheet(worksheet, locations)
    locations.each do |location|
      worksheet.append_row(column_bodies.map {|col| location[col]})

      append_to_sheet(worksheet, location['children']) if location['children'].present?
    end
  end

  private
    def column_headers
      ['Code', 'Parent code', 'Location name', 'Type', 'Total caller']
    end

    def column_bodies
      ['code', 'parent_id', 'name_en', 'kind', 'callers_count']
    end

    def format_data(locations, parent_kind=nil)
      locations = locations.as_json

      locations.each do |location|
        location['callers_count'] = caller_in_location[location['code']].to_i
        location['children'] = []

        child_kind = child_kinds[parent_kind]

        next if child_kind.nil?

        children = all_locations.select { |loc| loc.parent_id == location['code'] && loc.kind == child_kind }

        location['children'] = format_data(children, child_kind) if children.present?
      end

      locations
    end

    def child_kinds
      { 'province' => 'district', 'district' => 'commune' }
    end

    def all_locations
      @all_locations ||= Location.all
    end

    def caller_in_location
      return @callers if @callers.present?

      @callers = callers_group_by(:province_id)
      @callers = @callers.merge(callers_group_by(:district_id))
      @callers = @callers.merge(callers_group_by(:commune_id))
      @callers
    end

    def callers_group_by(field)
      User.where('date(last_datetime) >= ? AND date(last_datetime) <= ?', @start_date, @end_date).group(field).count
    end
end
