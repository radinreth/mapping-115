class WelcomeController < ApplicationController
  before_action :set_daterange

  def index
    @kind = params[:kind] || 'province'
    @date_start, @date_end = @date_range.split('-')

    gon.locations = Location.left_outer_joins(:callers)
                            .where('locations.kind=?', @kind)
                            .where('users.last_datetime IS NULL OR users.last_datetime BETWEEN ? AND ?', @date_start, @date_end)
                            .where('callers_count > 0')
                            .where.not(lat: nil)
                            .where.not(lng: nil)
                            .as_json
  end

  private

  def set_daterange
    current_date = Date.current.strftime('%Y/%m/%d')
    @date_range = params['daterange'] || "#{current_date} - #{current_date}"
  end
end
