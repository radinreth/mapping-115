# work as verboice external service url
class CallerLogsController < ApplicationController
  skip_before_action :authenticate_admin!
  skip_before_action :verify_authenticity_token

  def create
    CallerWorker.perform_async(formated_phone_number)
    render json: { msg: 'ok' }, status: :ok
  end

  private

  def formated_phone_number
    params[:address].sub(/^0/, '855')
  end
end
