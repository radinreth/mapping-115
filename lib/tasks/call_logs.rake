# frozen_string_literal: true

require 'csv'

namespace :call_logs do
  desc 'Plot caller\'s location on map'
  task fetch: :environment do
    CSV.foreach('lib/samples/call_logs_sample.csv', headers: true) do |row|
      hash = row.to_hash
      phone_number = hash['Caller ID']
      p "Logging: #{phone_number}..."
      CallerWorker.perform_async(phone_number)
      sleep 5
    end
  end
end
