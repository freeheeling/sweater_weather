class UnsplashService
  def image_data(location)
    get_json(location, 'search/photos')
  end

  private

    def get_json(location, url)
      response = conn(location).get(url)
      JSON.parse(response.body, symbolize_names: true)[:results]
    end

    def conn(location)
      Faraday.new(url: 'https://api.unsplash.com/') do |f|
        f.adapter(Faraday.default_adapter)
        f.params['client_id'] = ENV['UNSPLASH_KEY']
        f.params['query'] = location
      end
    end
end
