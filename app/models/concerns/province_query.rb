class ProvinceQuery
  def self.sql(start_date, end_date)
    Location.select('locations.code, COUNT(locations.code) AS callers_count, locations.lat, locations.lng')
      .joins('INNER JOIN users ON locations.code=SUBSTR(users.location_id, 1, 2)')
      .where.not(users: { lat: nil, lng: nil })
      .where(users: { last_datetime: start_date..end_date })
      .group(:code).to_sql
  end
end
