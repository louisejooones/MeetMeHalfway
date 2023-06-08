require 'google_maps_service'

# Set up global parameters
GoogleMapsService.configure do |config|
  config.key = Rails.application.config.google_maps_api_key
  config.retry_timeout = 20
  config.queries_per_second = 10
end

# Initialise client using global parameters
$gmaps = GoogleMapsService::Client.new