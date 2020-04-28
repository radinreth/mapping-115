class CallerLogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    phone_number = params[:address]
    CallerWorker.perform_asyn(phone_number)
    render json: { msg: 'ok' }
  end
end
