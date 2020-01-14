class GiphyService
  def url_data
    get_json('gifs/search')
  end

  private

    def get_json(url)
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn(summary)
      Faraday.new(url: 'https://api.giphy.com/v1/') do |f|
        f.adapter(Faraday.default_adapter)
        f.params['api_key'] = ENV['GIPHY_KEY']
        f.params['q'] = summary
      end
    end
end
