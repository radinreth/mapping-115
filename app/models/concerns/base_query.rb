class BaseQuery
  def self.sql(start_date, end_date, location_code_length)
    Location.unscoped
            .select('locations.name_km AS name, locations.code, COUNT(locations.code) AS callers_count, locations.lat, locations.lng')
            .joins("INNER JOIN users ON locations.code=SUBSTR(users.location_id, 1, #{location_code_length})")
            .where.not(lat: nil)
            .where.not(lng: nil)
            .where.not(users: { lat: nil })
            .where.not(users: { lng: nil })
            .where(users: { last_datetime: start_date..end_date })
            .group(:code).to_sql
  end
end
