class Api::V1::BackgroundsController < ApplicationController
  def show
    location = params[:location]

    # unsplash
    conn = Faraday.new(url: 'https://api.unsplash.com/') do |f|
      f.adapter(Faraday.default_adapter)
      f.params['client_id'] = ENV['UNSPLASH_KEY']
      f.params['query'] = location
    end

    response = conn.get('search/photos')
    images_data = JSON.parse(response.body, symbolize_names: true)

    image_uri = images_data[:results][0][:urls][:raw]
  end
end
