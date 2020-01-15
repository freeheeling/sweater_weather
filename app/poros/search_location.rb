class SearchLocation
  def initialize(location_data)
    @location_data = location_data
  end

  def city_state_country
    @location_data.map do |data|
      {
        city: data[0][:long_name],
        state: data[2][:short_name],
        country: data[3][:long_name]
      }
    end
  end
end
