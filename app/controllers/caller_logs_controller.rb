# work as verboice external service url
class CallerLogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    options = {
      call_id: params['CallSid'].to_i,
      last_datetime: Time.current
    }
    CallerWorker.perform_async(params[:address], options)
    render json: { msg: 'ok' }, status: :ok
  end
end
