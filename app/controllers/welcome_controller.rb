class WelcomeController < ApplicationController
  def index
    gon.locations = Location.where(kind: 'province')
  end
end
