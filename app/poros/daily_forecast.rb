class DailyForecast
  def initialize(daily_weather_data)
    @daily_data = daily_weather_data
  end

  def next_five_days
    @daily_data.map do |day|
      {
        summary_today: day[:summary],
        daily_day: Time.at(day[:time]).strftime('%A'),
        daily_high: (day[:temperatureHigh]).round,
        daily_low: (day[:temperatureLow]).round,
        daily_icon: day[:icon],
        daily_precip_percent: (day[:precipProbability]*100).to_i,
        daily_precip_type: day[:precipType]
      }
    end[1..5]
  end
end
