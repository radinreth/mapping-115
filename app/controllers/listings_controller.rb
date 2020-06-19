class ListingsController < ApplicationController
  def index
    @provinces = LocationDecorator.new.provinces
  end

  def provinces
    render json: LocationDecorator.new.provinces
  end

  def child_locations
    query = LocationDecorator.new(parent_id: params[:id])

    render json: query.get_data
  end
end
