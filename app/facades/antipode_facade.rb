class AntipodeFacade
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
  end

  def anti_lat
    AmypodeService.new.anti_coords(location)[:lat]
  end

  def anti_long
    AmypodeService.new.anti_coords(location)[:long]
  end

  private

    attr_reader :location
end
