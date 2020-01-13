class AnitpodeService
  def
    get_json
  end

  private

    def get_json
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn(location)
      Faraday.new(url: 'http://amypode.herokuapp.com/api/v1/') do |f|
        f.adapter(Faraday.default_adapter)
        f.headers['api_key'] = ENV['ANTIPODE_KEY']
        f.params['lat'] = lat
        f.params['long'] = long
    end
end
