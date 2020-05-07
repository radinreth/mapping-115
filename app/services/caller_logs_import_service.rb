require 'csv'

class CallerLogsImportService
  def self.process(filepath)
    interval = 0
    ::CSV.foreach(filepath, headers: true) do |row|
      interval += ENV['CALL_LOGS_FETCH_INTERVAL'].to_i
      hash = row.to_hash
      phone_number = hash['Caller ID']
      last_datetime = Time.zone.parse(hash['Started'])
      p "Logging: #{phone_number}..."
      CallerWorker.perform_in(interval.seconds, phone_number, last_datetime)
    end
  end
end
