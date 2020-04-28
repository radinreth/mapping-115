class CallerWorker
  include Sidekiq::Worker

  def perform(phone_number)
    CallerService.run(phone_number)
    Rails.logger.debug "Running job #{phone_number}"
  end
end
