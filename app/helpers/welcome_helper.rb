module WelcomeHelper
  %w[province district commune spot].each do |kind|
    define_method "active_#{kind}".to_sym do
      return 'active' if kind == 'spot' && params[:kind].nil?

      params[:kind] == kind ? 'active' : ''
    end
  end
end
