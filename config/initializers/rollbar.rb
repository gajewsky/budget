Rollbar.configure do |config|
  config.access_token = 'access_token'

  config.enabled = false if Rails.env.test?

  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end
