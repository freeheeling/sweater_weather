class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :search_location,
             :current_forecast,
             :daily_forecast,
             :hourly_forecast
end
