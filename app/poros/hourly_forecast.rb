class HourlyForecast
  def initialize(hourly_weather_data)
    @hourly_data = hourly_weather_data
  end

  def next_eight_hours
    @hourly_data.map do |hour|
      {
        time_hour: Time.at(hour[:time]).strftime('%-I %p'),
        icon_description: hour[:icon],
        temp_F: (hour[:temperature]).round
      }
    end[0..7]
  end
end
