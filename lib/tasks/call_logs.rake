# frozen_string_literal: true

require 'csv'

namespace :call_logs do
  desc "Plot caller's location on map"
  task fetch: :environment do
    ::CallerLogsImportService.process('lib/samples/Call_logs_(2020-05-05).csv')
  end
end
