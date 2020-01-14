class GeocodeService
  def geocode_data(location)
    get_json(location, 'geocode/json')
  end

  private

    def get_json(location, url)
      response = conn(location).get(url)
      JSON.parse(response.body, symbolize_names: true)[:results][0]
    end

    def conn(location)
      Faraday.new(url: 'https://maps.googleapis.com/maps/api/') do |f|
        f.adapter(Faraday.default_adapter)
        f.params['key'] = ENV['GEOCODE_KEY']
        f.params['address'] = location
      end
    end
end
