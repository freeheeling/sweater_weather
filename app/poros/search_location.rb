class SearchLocation
  def initialize(location_data)
    @location_data = location_data
  end

  def city_state_country
    {
      city: location_data[0][:long_name],
      state_abbrev: location_data[2][:short_name],
      country: location_data[3][:long_name]
    }
  end

  private

    attr_reader :location_data
end
