class DailyForecast
  def initialize(daily_weather_data)
    @daily_data = daily_weather_data
  end

  def next_five_days
    @daily_data.map do |day|
      {
        summary: day[:summary],
        day: Time.at(day[:time]).strftime('%A'),
        high_temp_F: (day[:temperatureHigh]).round,
        low_temp_F: (day[:temperatureLow]).round,
        icon_description: day[:icon],
        precip_percent: (day[:precipProbability]*100).to_i,
        precip_type: day[:precipType]
      }
    end[1..5]
  end
end
