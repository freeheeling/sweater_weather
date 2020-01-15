class ForecastFacade
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
  end

  def geo_data
    @geo_data ||= GeocodeService.new.geocode_data(location)
  end

  def dark_data
    lat = geo_data[:geometry][:location][:lat]
    long = geo_data[:geometry][:location][:lng]
    @dark_data ||= DarkskyService.new.darksky_data(lat, long)
  end

  def search_location
    data = geo_data[:address_components]
    {
      city: data[0][:long_name],
      state: data[2][:short_name],
      country: data[3][:long_name]
    }
  end

  def current_forecast
    data = dark_data[:currently]
    {
      current_date: Time.at(data[:time]).strftime('%I:%M %p %-m/%d'),
      current_temp: (data[:temperature]).round,
      feels_like: (data[:apparentTemperature]).round,
      current_icon: data[:icon],
      humidity: (data[:humidity]*100).to_i,
      visibility: data[:visibility],
      uv_index: data[:uvIndex]
    }
  end

  def daily_forecast
    data = dark_data[:daily][:data][0]
    {
      summary_today: data[:summary],
      daily_day: Time.at(data[:time]).strftime('%A'),
      daily_high: (data[:temperatureHigh]).round,
      daily_low: (data[:temperatureLow]).round,
      daily_icon: data[:icon],
      daily_precip_percent: (data[:precipProbability]*100).to_i,
      daily_precip_type: data[:precipType]
    }
  end

          # dark_data[:daily][:data].map do |day|
          #   day[:summary] = day[:summary]
          # end
          # # => ["Clear throughout the day.",...]
          #
          # dark_data[:daily][:data].map do |day|
          #   day[:temperatureHight] = (day[:temperatureHigh]).round
          # end
          # # => [46, 56, 51, 49, 48, 37, 49, 47]
          #
          # dark_data[:daily][:data].map do |day|
          #   day[:time] = Time.at(day[:time]).strftime('%A')
          # end
          # # =>


  def hourly_forecast
    hourly_data = dark_data[:hourly][:data]
    HourlyForecast.new(hourly_data).next_eight_hours
  end


  private

    attr_reader :location
end
