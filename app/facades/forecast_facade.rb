class ForecastFacade
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
  end

  def lat
    GeocodeService.new.coords(location)[:lat]
  end

  def long
    GeocodeService.new.coords(location)[:lng]
  end

  def search_location
    data = GeocodeService.new.address(location)
    {
      city: data[0][:long_name],
      state: data[2][:short_name],
      country: data[3][:long_name]
    }
  end

  def current_forecast
    data = DarkskyService.new.current(lat, long)
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
    data = DarkskyService.new.daily(lat, long)
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

  def hourly_forecast
    data = DarkskyService.new.hourly(lat, long)
    {
      hourly_icon: data[:icon],
      hourly_time: Time.at(data[:time]).strftime('%-I %p'),
      hourly_temp: (data[:temperature]).round
    }
  end

  private

    attr_reader :location
end
