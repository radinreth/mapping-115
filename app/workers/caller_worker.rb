class CallerWorker
  include Sidekiq::Worker

  def perform(phone_number)
    CallerService.run(phone_number)
  end
end
