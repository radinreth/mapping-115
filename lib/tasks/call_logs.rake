# frozen_string_literal: true

require 'csv'

namespace :call_logs do
  desc "Plot caller's location on map"
  task fetch: :environment do
    interval = 0
    CSV.foreach('lib/samples/call_logs.csv', headers: true) do |row|
      interval += 5
      hash = row.to_hash
      phone_number = hash['Caller ID']
      p "Logging: #{phone_number}..."
      CallerWorker.perform_in(interval.seconds, phone_number)
    end
  end
end
