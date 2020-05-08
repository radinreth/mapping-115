class CallerWorker
  include Sidekiq::Worker

  def perform(phone_number, options)
    CallerService.run(phone_number, options)
  end
end
