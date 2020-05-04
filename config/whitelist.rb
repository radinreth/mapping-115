class Whitelist
  def matches?(request)
    klass.allowed_hosts.include?(request.host)
  end

  def self.allowed_hosts
    ENV['ALLOWED_HOSTS'].split(',').map(&:strip)
  end

  private

  def klass
    @klass ||= self.class
  end
end
