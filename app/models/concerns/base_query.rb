class BaseQuery
  def self.sql(start_date, end_date, location_code_length)
    Location.select('locations.code, COUNT(locations.code) AS callers_count, locations.lat, locations.lng')
            .joins("INNER JOIN users ON locations.code=SUBSTR(users.location_id, 1, #{location_code_length})")
            .where.not(users: { lat: nil, lng: nil })
            .where(users: { last_datetime: start_date..end_date })
            .group(:code).to_sql
  end
end
