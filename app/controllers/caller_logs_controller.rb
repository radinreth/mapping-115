# work as verboice external service url
class CallerLogsController < ApplicationController
  skip_before_action :authenticate_admin!
  skip_before_action :verify_authenticity_token

  def create
    CallerWorker.perform_async(params[:address])
    render json: { msg: 'ok' }, status: :ok
  end
end
