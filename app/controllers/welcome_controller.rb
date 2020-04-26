class WelcomeController < ApplicationController
  def index
    gon.locations = Location.where(kind: (params[:kind] || 'province'))
                            .where.not(lat: nil, lng: nil)
                            .as_json(methods: :nested_count)
  end
end
