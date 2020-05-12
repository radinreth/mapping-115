class SpotQuery
  def self.sql(start_date, end_date)
    Location.unscoped
            .select('users.location_detail AS name, locations.name_km, locations.code, COUNT(locations.code) AS callers_count, users.lat, users.lng')
            .joins(:callers)
            .where.not(users: { lat: nil })
            .where.not(users: { lng: nil })
            .where('DATE(last_datetime) BETWEEN ? AND ?', start_date, end_date)
            .group('users.location_detail, locations.code, users.lat, users.lng').to_sql
  end
end
