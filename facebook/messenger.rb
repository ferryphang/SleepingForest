Facebook::Messenger.configure do |config|
  config.access_token = ""
  config.app_secret = ""
  config.verify_token = "" 
end
Facebook::Messenger::Subscriptions.subscribe
