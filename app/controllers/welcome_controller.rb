class WelcomeController < ApplicationController
  before_action :set_daterange
  before_action :set_options

  def index
    @query = ::QueryDecorator.new(@options)

    gon.locations = @query.locations
    gon.indicator = @query.indicator
  end

  private

  def set_options
    @kind = params[:kind] || 'spot'
    @start_date, @end_date = @date_range.split('-')
    @options = { kind: @kind, start_date: @start_date, end_date: @end_date }
  end

  def set_daterange
    current_date = Date.current.strftime('%Y/%m/%d')
    @date_range = params['daterange'] || "#{current_date} - #{current_date}"
  end
end
