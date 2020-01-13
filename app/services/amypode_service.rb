class AmypodeService
  def anti_coords(lat, long)
    get_json_coords("antipodes?lat=#{lat}&long=#{long}")
  end

  private

    def get_json_coords(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    end

    def conn
      Faraday.new(url: 'http://amypode.herokuapp.com/api/v1/') do |f|
        f.adapter(Faraday.default_adapter)
        f.headers['api_key'] = ENV['AMYPODE_KEY']
      end
    end
end
