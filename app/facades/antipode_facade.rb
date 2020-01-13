class AntipodeFacade
  attr_reader :id

  def initialize(location)
    @id = 1
    @location = location
  end

  def type
    'antipode'
  end

  def lat
    GeocodeService.new.coords(location)[:lat]
  end

  def long
    GeocodeService.new.coords(location)[:lng]
  end

  def location_name
    ReverseGeocodeService.new.city(location)
  end

  def anti_lat
    AmypodeService.new.anti_coords(location)[:lat]
  end

  def anti_long
    AmypodeService.new.anti_coords(location)[:long]
  end

  def current_temperature
    DarkskyService.new.current(anti_lat, anti_long)[:temperature]
  end

  def summary
    DarkskyService.new.daily(anti_lat, anti_long)[:summary]
  end

  def search_location
    location
  end

  private

    attr_reader :location
end
