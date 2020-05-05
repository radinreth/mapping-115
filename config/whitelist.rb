class Whitelist
  def matches?(request)
    klass.allowed_hosts.include?(request.remote_ip) || request.host == 'localhost'
  end

  def self.allowed_hosts
    ENV['ALLOWED_HOSTS'].split(',').map(&:strip)
  end

  private

  def klass
    @klass ||= self.class
  end
end
