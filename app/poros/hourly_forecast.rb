class HourlyForecast
  def initialize(hourly_weather_data)
    @hourly_data = hourly_weather_data
  end

  def next_eight_hours
    @hourly_data.map do |hour|
      {
        hourly_icon: hour[:icon],
        hourly_time: Time.at(hour[:time]).strftime('%-I %p'),
        hourly_temp: (hour[:temperature]).round
      }
    end.take(8)
  end
end
