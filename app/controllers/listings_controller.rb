class ListingsController < ApplicationController
  def index
    @provinces = LocationDecorator.new.provinces
  end

  def districts
    query = LocationDecorator.new(province_id: params[:province_id])

    render json: query.districts
  end

  def communes
    query = LocationDecorator.new(district_id: params[:district_id])

    render json: query.communes
  end
end
