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

  def city
    GeocodeService.new.address(location)[0][:long_name]
  end

  def state
    GeocodeService.new.address(location)[2][:long_name]
  end

  def country
    GeocodeService.new.address(location)[3][:long_name]
  end

  def current_date
    DarkskyService.new.current(lat, long)[:time]
  end

  def current_temp
    DarkskyService.new.current(lat, long)[:temperature]
  end

  def feels_like
    DarkskyService.new.current(lat, long)[:apparentTemperature]
  end

  def current_icon
    DarkskyService.new.current(lat, long)[:icon]
  end

  def humidity
    DarkskyService.new.current(lat, long)[:humidity]
  end

  def visibility
    DarkskyService.new.current(lat, long)[:visibility]
  end

  def uv_index
    DarkskyService.new.current(lat, long)[:uvIndex]
  end

  def summary_today
    DarkskyService.new.daily(lat, long)[:summary]
  end

  def daily_day
    DarkskyService.new.daily(lat, long)[:time]
  end

  def daily_high
    DarkskyService.new.daily(lat, long)[:temperatureHigh]
  end

  def daily_low
    DarkskyService.new.daily(lat, long)[:temperatureLow]
  end

  def daily_icon
    DarkskyService.new.daily(lat, long)[:icon]
  end

  def daily_precip_percent
    DarkskyService.new.daily(lat, long)[:precipProbability]
  end

  def daily_precip_type
    DarkskyService.new.daily(lat, long)[:precipType]
  end

  def summary_tonight
    DarkskyService.new.hourly(lat, long)[:summary]
    # unix_tstamp = DarkskyService.new.hourly(lat, long)[:time]
    # where Time.at(unix_tstamp).strftime('%H') = '21'
    # Time.at(DarkskyService.new.hourly(lat, long)[:time]).strftime('%H')
  end

  def hourly_icon
    DarkskyService.new.hourly(lat, long)[:icon]
  end

  def hourly_time
    DarkskyService.new.hourly(lat, long)[:time]
  end

  def hourly_temp
    DarkskyService.new.hourly(lat, long)[:temperature]
  end

  private

    attr_reader :location
end
