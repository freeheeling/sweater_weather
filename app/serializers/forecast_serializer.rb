class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :search_location,
             :current_forecast,
             :daily_forecast,
             :hourly_forecast
end
