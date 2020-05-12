class QueryDecorator
  attr_reader :kind, :start_date, :end_date

  def initialize(options)
    @kind = options[:kind]
    @start_date = options[:start_date]
    @end_date = options[:end_date]
  end

  def all_count
    callers_count.first['count']
  end

  def inperiod_count
    callers_count.last['count']
  end

  def locations
    @locations ||= ::Location.send(:query, kind, start_date, end_date)
  end

  def indicator
    return unless max_count

    { max1: (max_count / 3), max2: (max_count / 3) * 2, max: max_count }
  end

  private

  def callers_count
    User.connection.execute(" SELECT COUNT(*) FROM users
                              UNION ALL
                              SELECT COUNT(*) FROM users
                                WHERE DATE(last_datetime) BETWEEN '#{start_date}' AND '#{end_date}'").to_a
  end

  def max_count
    locations.max_by { |loc| loc['callers_count'] }['callers_count'] rescue nil
  end
end
