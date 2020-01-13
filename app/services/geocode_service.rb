class GeocodeService
  def coords(location)
    get_json_coords(location, 'geocode/json')
  end

  def address(location)
    get_json_address(location, 'geocode/json')
  end

  private

    def get_json_coords(location, url)
      response = conn(location).get(url)
      JSON.parse(response.body, symbolize_names: true)[:results][0][:geometry][:location]
    end

    def get_json_address(location, url)
      response = conn(location).get(url)
      JSON.parse(response.body, symbolize_names: true)[:results][0][:address_components]
    end

    def conn(location)
      Faraday.new(url: 'https://maps.googleapis.com/maps/api/') do |f|
        f.adapter(Faraday.default_adapter)
        f.params['key'] = ENV['GEOCODE_KEY']
        f.params['address'] = location
      end
    end
end
