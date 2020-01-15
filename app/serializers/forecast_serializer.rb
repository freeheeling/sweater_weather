class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :search_location,
             :current_weather,
             :daily_forecast,
             :hourly_forecast
end
