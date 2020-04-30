class WelcomeController < ApplicationController
  before_action :set_daterange

  def index
    @kind = params[:kind] || 'province'
    @date_start, @date_end = @date_range.split('-')

    gon.locations = Location.send(@kind.to_sym)
  end

  private

  def set_daterange
    current_date = Date.current.strftime('%Y/%m/%d')
    @date_range = params['daterange'] || "#{current_date} - #{current_date}"
  end
end
