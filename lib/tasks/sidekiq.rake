namespace :sidekiq do
  desc 'Clear sidekiq jobs'
  task clear: :environment do
    Sidekiq::Queue.all.each(&:clear)
    Sidekiq::RetrySet.new.clear
    Sidekiq::ScheduledSet.new.clear
    Sidekiq::DeadSet.new.clear
  end

end
