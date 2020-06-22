class ListingsController < ApplicationController
  def index
    @provinces = LocationDecorator.new.provinces

    respond_to do |format|
      format.html
      format.json { render :json => @provinces.to_json }
    end
  end

  def locations
    query = LocationDecorator.new(parent_id: params[:id])

    render json: query.get_data
  end
end
