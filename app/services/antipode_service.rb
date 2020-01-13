class AmypodeService
  def anti_coords
    get_json_coords(location, )
  end

  private

    def get_json_coords(location, url)
      response = conn(location).get(url)
      JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    end

    def conn(location)
      Faraday.new(url: 'http://amypode.herokuapp.com/api/v1/') do |f|
        f.adapter(Faraday.default_adapter)
        f.headers['api_key'] = ENV['AMYPODE_KEY']
      end
    end
end
