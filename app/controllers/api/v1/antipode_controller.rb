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
    conn = Faraday.new(url: 'http://amypode.herokuapp.com/api/v1/') do |f|
      f.adapter(Faraday.default_adapter)
      f.headers['api_key'] = ENV['ANTIPODE_KEY']
      f.params['lat'] = lat
      f.params['long'] = long
    end

    response = conn.get("antipode?lat=#{lat}&long=#{long}")

    json = JSON.parse(response.body, symbolize_names: true)

    # antipode_data = AntipodeFacade.new(location)
    # render json: AntipodeSerializer.new(antipode_data)
  end
end
