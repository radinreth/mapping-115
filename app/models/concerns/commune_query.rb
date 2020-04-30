class CommuneQuery < BaseQuery
  def self.sql(start_date, end_date)
    super(start_date, end_date, 6)
  end
end
