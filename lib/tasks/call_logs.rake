# frozen_string_literal: true

require 'csv'

namespace :call_logs do
  desc "Plot caller's location on map"
  task fetch: :environment do
    interval = 0
    CSV.foreach('lib/samples/call_logs.csv', headers: true) do |row|
      interval += ENV['CALL_LOGS_FETCH_INTERVAL'].to_i
      hash = row.to_hash
      phone_number = hash['Caller ID']
      last_datetime = Time.zone.parse(hash['Started'])
      p "Logging: #{phone_number}..."
      CallerWorker.perform_in(interval.seconds, phone_number, last_datetime)
    end
  end
end
