class ReverseGeocodeService
  def city(location)
    get_json_city(location, 'geocode/json')
  end

  private

    def get_json_city(location, url)
      response = conn(location).get(url)
      JSON.parse(response.body, symbolize_names: true)[:results][0][:address_components][0][:long_name]
    end

    def conn(location)
      Faraday.new(url: 'https://maps.googleapis.com/maps/api/') do |f|
        f.adapter(Faraday.default_adapter)
        f.params['key'] = ENV['GEOCODE_KEY']
        f.params['latlng'] = "#{anti_lat},#{anti_long}"
      end
    end
end
