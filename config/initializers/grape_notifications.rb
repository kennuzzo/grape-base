ActiveSupport::Notifications.subscribe "grape.request" do |*args|
  Rails.logger.info args
end