class DarkskyService
  def darksky_data(lat, long)
    get_json("/forecast/#{ENV['DARKSKY_KEY']}/#{lat},#{long}")
  end

  private

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn
      Faraday.new(url: 'https://api.darksky.net') do |f|
        f.adapter(Faraday.default_adapter)
      end
    end
end
