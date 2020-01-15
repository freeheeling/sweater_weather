class CurrentWeather
  def initialize(current_weather_data)
    @current_data = current_weather_data
  end

  def currently
    @current_data.map do |current|
      {
        current_date: Time.at(current[:time]).strftime('%I:%M %p %-m/%d'),
        current_temp: (current[:temperature]).round,
        feels_like: (current[:apparentTemperature]).round,
        current_icon: current[:icon],
        humidity: (current[:humidity]*100).to_i,
        visibility: current[:visibility],
        uv_index: current[:uvIndex]
      }
    end
  end
end
