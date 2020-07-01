class ListingsController < ApplicationController
  before_action :set_daterange

  def index
    @locations = LocationDecorator.new(@options).data

    respond_to do |format|
      format.html {
        @count = @locations.inject(0) { |sum, hash| sum + hash['callers_count'].to_i }
      }
      format.json { render :json => @locations }
    end
  end

  def download
    service = ListingService.new(@options)

    send_data(service.export_excel, filename: 'listings.xlsx')
  end

  private
    def set_daterange
      current_date = Date.current.strftime('%Y/%m/%d')
      @date_range = params['daterange'] || "#{current_date} - #{current_date}"
      @start_date, @end_date = @date_range.split('-')

      @options = { start_date: @start_date, end_date: @end_date, parent_id: params[:id] }
    end
end
