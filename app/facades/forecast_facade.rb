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
    location_data = geo_data[:address_components]
    SearchLocation.new(location_data).city_state_country
  end

  def current_weather
    CurrentWeather.new(dark_data).currently
  end

  def daily_forecast
    daily_data = dark_data[:daily][:data]
    DailyForecast.new(daily_data).next_five_days
  end

  def hourly_forecast
    hourly_data = dark_data[:hourly][:data]
    HourlyForecast.new(hourly_data).next_eight_hours
  end

  private

    attr_reader :location
end
