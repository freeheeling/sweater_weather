class Api::V1::GifsController < ApplicationController
  def index
    location = params[:location]

    geo_conn = Faraday.new(url: 'https://maps.googleapis.com/maps/api/') do |f|
      f.adapter(Faraday.default_adapter)
      f.params['key'] = ENV['GEOCODE_KEY']
      f.params['address'] = location
    end

    geo_response = geo_conn.get('geocode/json')
    parsed_json = JSON.parse(geo_response.body, symbolize_names: true)
    location_data = parsed_json[:results][0]

    lat = location_data[:geometry][:location][:lat]
    long = location_data[:geometry][:location][:lng]

    dark_conn = Faraday.new(url: 'https://api.darksky.net') do |f|
      f.adapter(Faraday.default_adapter)
    end

    dark_response = dark_conn.get("/forecast/#{ENV['DARKSKY_KEY']}/#{lat},#{long}")
    parse_json = JSON.parse(dark_response.body, symbolize_names: true)
    daily_weather_data = parse_json[:daily][:data]

    giphy_forecast = daily_weather_data.map do |day|
      gif_conn = Faraday.new(url: 'https://api.giphy.com/v1/') do |f|
        f.adapter(Faraday.default_adapter)
        f.params['api_key'] = ENV['GIPHY_KEY']
        f.params['q'] = day[:summary]
      end

      gif_response = gif_conn.get('gifs/search')
      parsed_json = JSON.parse(gif_response.body, symbolize_names: true)
      gif_data = parsed_json[:data][0]

      url = gif_data[:images][:downsized_large][:url]

      Giphcast.new(day[:time], day[:summary], url)
    end

    images = Images.new(giphy_forecast)

    render json: GiphySerializer.new(images)
  end
end
