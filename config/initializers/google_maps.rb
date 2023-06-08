Google::Maps.configure do |config|
    config.authentication_mode = Google::Maps::Configuration::API_KEY
    config.api_key = Rails.application.config.google_maps_api_key
end