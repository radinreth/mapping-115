class WelcomeController < ApplicationController
  def index
    gon.locations = Location.where(kind: (params[:kind] || 'province'))
                            .where('callers_count > 0')
                            .where.not(lat: nil, lng: nil).as_json
  end
end
