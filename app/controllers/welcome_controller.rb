class WelcomeController < ApplicationController
  def index
    gon.locations = Location.where(kind: 'province').as_json(methods: :nested_count)
  end
end
