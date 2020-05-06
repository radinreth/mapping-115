class CallerWorker
  include Sidekiq::Worker

  def perform(phone_number, last_datetime)
    CallerService.run(phone_number, last_datetime)
  end
end
