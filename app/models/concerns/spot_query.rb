class SpotQuery
  def self.sql(start_date, end_date)
    Location.select('locations.code, COUNT(locations.code) AS callers_count, users.lat, users.lng')
            .joins(:callers)
            .where.not(users: { lat: nil, lng: nil })
            .where(users: { last_datetime: start_date..end_date })
            .group('locations.code, users.lat, users.lng').to_sql
  end
end
