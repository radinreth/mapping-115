class QueryDecorator
  attr_reader :kind, :start_date, :end_date

  def initialize(options)
    @kind = options[:kind]
    @start_date = options[:start_date]
    @end_date = options[:end_date]
  end

  def callers_count
    @callers_count ||= ::User.where.not(lat: nil, lng: nil).count
  end

  def locations
    @locations ||= ::Location.send(:query, kind, start_date, end_date)
  end

  def indicator
    return unless max_count

    { max1: (max_count / 3), max2: (max_count / 3) * 2, max: max_count }
  end

  private

  def max_count
    locations.max_by { |loc| loc['callers_count'] }['callers_count'] rescue nil
  end
end
