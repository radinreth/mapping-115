# frozen_string_literal :true

module Api
  class CallersController < ApplicationController
    before_action :set_location
    skip_before_action :verify_authenticity_token

    def create
      @caller = @location.callers.build(caller_params)
      if @caller.save
        render json: { msg: 'success' }
      else
        render json: { msg: 'fail' }
      end
    end

    private

    def set_location
      ncdd_code = caller_params['ncdd_code']

      begin
        @location = Location.find(ncdd_code)
      rescue ActiveRecord::RecordNotFound => e
        new_code = ''
        ncdd_code.split('').each_slice(2).map(&:join).each do |code|
          new_code += code
          begin
            Location.find(new_code)
          rescue ActiveRecord::RecordNotFound => e
            @location = pumi_location(new_code)
          end
        end
      end
    end

    def pumi_location(code)
      location_kind = Location.location_kind(code)
      loc_pumi = "pumi/#{location_kind}".classify.constantize.find_by_id(code)
      if loc_pumi.present?
        location = Location.create do |loc|
          loc.code      = loc_pumi.id
          loc.name_en   = loc_pumi.name_latin
          loc.name_km   = loc_pumi.name_km
          loc.kind      = location_kind
          loc.parent_id = loc_pumi.id[0...-2]
        end
      end

      location
    end

    def raw_params
      params.permit(data: [:phone_number, :last_datetime, :call_id, Location: %i[Latitude Longitude NCDD_Code]])
    end

    def caller_params
      helpers.normalize_params(raw_params['data'])
    end
  end
end
