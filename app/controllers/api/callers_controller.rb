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
            location_kind = Location.location_kind(new_code)
            loc_pumi = "pumi/#{location_kind}".classify.constantize.find_by_id(new_code) # 0812 => raise
            if loc_pumi
              @location = Location.create(code: loc_pumi.id, name_en: loc_pumi.name_latin, name_km: loc_pumi.name_km, kind: location_kind, parent_id: loc_pumi.id[0...-2])
            end
          end
        end
      end
    end

    def raw_params
      params.permit(data: [:phone_number, Location: %i[LastDate LastLocalTime Latitude Longitude NCDD_Code]])
    end

    def caller_params
      helpers.normalize_params(raw_params['data'])
    end
  end
end
