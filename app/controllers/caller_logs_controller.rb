class CallerLogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    CallerWorker.perform_asyn(params[:address])
    render json: { msg: 'ok' }
  end
end
