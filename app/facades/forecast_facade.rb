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
      current_date: data[:time],
      current_temp: data[:temperature],
      feels_like: data[:apparentTemperature],
      current_icon: data[:icon],
      humidity: data[:humidity],
      visibility: data[:visibility],
      uv_index: data[:uvIndex]
    }
  end

  def daily_forecast
    data = DarkskyService.new.daily(lat, long)
    {
      summary_today: data[:summary],
      daily_day: data[:time],
      daily_high: data[:temperatureHigh],
      daily_low: data[:temperatureLow],
      daily_icon: data[:icon],
      daily_precip_percent: data[:precipProbability],
      daily_precip_type: data[:precipType]
    }
  end

  def hourly_forecast
    data = DarkskyService.new.hourly(lat, long)
    {
      hourly_icon: data[:icon],
      hourly_time: data[:time],
      hourly_temp: data[:temperature]
    }
  end

  private

    attr_reader :location
end
