class Whitelist
  def matches?(request)
    Rails.logger.debug "++++++++++#{request.remote_ip} #{request.host}"
    klass.allowed_hosts.include?(request.remote_ip) || %w[web localhost].include?(request.host)
  end

  def self.allowed_hosts
    ENV['ALLOWED_HOSTS'].split(',').map(&:strip)
  end

  private

  def klass
    @klass ||= self.class
  end
end
