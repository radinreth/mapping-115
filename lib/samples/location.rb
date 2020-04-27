# frozen_string_literal: true

require 'csv'

module Samples
  class Location

    def self.load
      %w[locations locations-full].each do |filename|
        load_from_file(filename)
      end
    end

    def self.load_from_file(filename)
      file_path = "#{Rails.root}/lib/samples/db/#{filename}.csv"
      unless File.file?(file_path)
        puts "Fail to import data. could not find #{file_path}"
        return
      end

      csv = CSV.read(file_path)
      csv.shift
      csv.each do |data|
        loc = ::Location.find_or_initialize_by(code: data[0])
        loc.name_en = data[1]
        loc.name_km = data[2]
        loc.kind = data[3]
        loc.parent_id = data[4]
        if data[5].present? && data[6].present?
          loc.lat = data[5]
          loc.lng = data[6]
        end
        loc.save
      end
    end
  end
end
