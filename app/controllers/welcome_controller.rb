class WelcomeController < ApplicationController
  before_action :set_daterange

  def index
    @kind = params[:kind] || 'spot'
    @start_date, @end_date = @date_range.split('-')

    gon.locations = admin_signed_in? ? Location.send(:query, @kind, @start_date, @end_date) : []
  end

  private

  def set_daterange
    current_date = Date.current.strftime('%Y/%m/%d')
    @date_range = params['daterange'] || "#{current_date} - #{current_date}"
  end
end
