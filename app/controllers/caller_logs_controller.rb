# work as verboice external service url
class CallerLogsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_admin!

  def create
    options = {
      call_id: params['CallSid'].to_i,
      last_datetime: Time.current
    }

    unless ::User.exists?(call_id: options[:call_id])
      CallerWorker.perform_async(params['address'], options)
    end

    render json: { msg: 'ok' }, status: :ok
  end
end
