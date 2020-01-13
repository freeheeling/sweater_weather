class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :lat,
             :long,
             :city,
             :state,
             :country,
             :current_date,
             :current_temp,
             :feels_like,
             :current_icon,
             :humidity,
             :visibility,
             :uv_index,
             :summary_today,
             :summary_tonight,
             :daily_day,
             :daily_icon,
             :daily_high,
             :daily_low,
             :daily_precip_percent,
             :daily_precip_type,
             :hourly_icon,
             :hourly_time,
             :hourly_temp
end
