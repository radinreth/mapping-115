class DistrictQuery < BaseQuery
  def self.sql(start_date, end_date)
    super(start_date, end_date, 4)
  end
end
