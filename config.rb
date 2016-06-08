require './secrets.yml'
Facebook::Messenger.configure do |config|
config.access_token = access_token
  config.app_secret = app_secret
  config.verify_token = verify_token
end

Facebook::Messenger::Subscriptions.subscribe
