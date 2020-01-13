class DarkskyService
  def current(lat, long)
    get_json_current("/forecast/#{ENV['DARKSKY_KEY']}/#{lat},#{long}")
  end

  def daily(lat, long)
    get_json_daily("/forecast/#{ENV['DARKSKY_KEY']}/#{lat},#{long}")
  end

  def hourly(lat, long)
    get_json_hourly("/forecast/#{ENV['DARKSKY_KEY']}/#{lat},#{long}")
  end

  private

    def get_json_current(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)[:currently]
    end

    def get_json_daily(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)[:daily][:data][0]
    end

    def get_json_hourly(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)[:hourly][:data][0]
    end

    def conn
      Faraday.new(url: 'https://api.darksky.net') do |f|
        f.adapter(Faraday.default_adapter)
      end
    end
end
