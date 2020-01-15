class CurrentWeather
  def initialize(current_weather_data)
    @current_data = current_weather_data
  end

  def currently
    {
      current_weather: current_data[:currently][:summary],
      time_and_date: Time.at(current_data[:currently][:time]).strftime('%I:%M %p %-m/%d'),
      temp_F: (current_data[:currently][:temperature]).round,
      feels_like_F: (current_data[:currently][:apparentTemperature]).round,
      icon_description: current_data[:currently][:icon],
      humidity_percent: (current_data[:currently][:humidity]*100).to_i,
      visibility_miles: current_data[:currently][:visibility],
      uv_index: current_data[:currently][:uvIndex],
      today_summary: current_data[:daily][:data][0][:summary],
      tonight_summary: next_night_hour_data[:summary]
    }
  end

  private

    attr_reader :current_data

    def next_night_hour_data
      current_data[:hourly][:data].find do |hour|
        hour[:icon].include?('night')
      end
    end
end
