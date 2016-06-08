Facebook::Messenger.configure do |config|
  config.access_token = "X"
  config.app_secret = "X"
  config.verify_token = "X"
end

Facebook::Messenger::Subscriptions.subscribe
