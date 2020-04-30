class ProvinceQuery < BaseQuery
  def self.sql(start_date, end_date)
    super(start_date, end_date, 2)
  end
end
