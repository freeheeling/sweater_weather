class Api::V1::AntipodeController < ApplicationController
  def index
    location = params[:location]

    # geocode
    conn = Faraday.new(url: 'https://maps.googleapis.com/maps/api/') do |f|
      f.adapter(Faraday.default_adapter)
      f.params['key'] = ENV['GEOCODE_KEY']
      f.params['address'] = location
    end

    response = conn.get('geocode/json')
    location_data = JSON.parse(response.body, symbolize_names: true)

    lat = location_data[:results][0][:geometry][:location][:lat]
    long = location_data[:results][0][:geometry][:location][:lng]

    # amypode
    amypode_conn = Faraday.new(url: 'http://amypode.herokuapp.com/api/v1/') do |f|
      f.adapter(Faraday.default_adapter)
      f.headers['api_key'] = ENV['AMYPODE_KEY']
    end

    amypode_response = amypode_conn.get("antipodes?lat=#{lat}&long=#{long}")
    antipode_data = JSON.parse(amypode_response.body, symbolize_names: true)

    anti_lat = antipode_data[:data][:attributes][:lat]
    anti_long = antipode_data[:data][:attributes][:long]

    # reverse geocode
    reverse_conn = Faraday.new(url: 'https://maps.googleapis.com/maps/api/') do |f|
      f.adapter(Faraday.default_adapter)
      f.params['key'] = ENV['GEOCODE_KEY']
      f.params['latlng'] = "#{anti_lat},#{anti_long}"
    end

    reverse_response = reverse_conn.get('geocode/json')
    reverse_location_data = JSON.parse(reverse_response.body, symbolize_names: true)

    antipode_city = reverse_location_data[:results][0][:address_components][0][:long_name]

    # darksky
    darksky_conn = Faraday.new(url: 'https://api.darksky.net') do |f|
      f.adapter(Faraday.default_adapter)
    end

    darsky_response = darksky_conn.get("/forecast/#{ENV['DARKSKY_KEY']}/#{anti_lat},#{anti_long}")
    weather_data = JSON.parse(darsky_response.body, symbolize_names: true)

    current_temp = weather_data[:currently][:temperature]
    summary = weather_data[:daily][:data][0][:summary]

    antipode_data = AntipodeFacade.new(location)
    render json: AntipodeSerializer.new(antipode_data)
  end
end
