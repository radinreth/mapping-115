class WelcomeController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_daterange

  def index
    @kind = params[:kind] || 'spot'
    @start_date, @end_date = @date_range.split('-')
    @callers_count = User.where.not(lat: nil, lng: nil).count
    @locations = Location.send(:query, @kind, @start_date, @end_date)
    max_count = @locations.max_by { |loc| loc['callers_count'] }['callers_count']
    gon.indicator = { max1: (max_count / 3), max2: (max_count / 3) * 2, max: max_count }
    gon.locations = @locations
  end

  private

  def set_daterange
    current_date = Date.current.strftime('%Y/%m/%d')
    @date_range = params['daterange'] || "#{current_date} - #{current_date}"
  end
end
