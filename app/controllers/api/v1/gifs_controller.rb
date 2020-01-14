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
    location_info = parsed_json[:results][0]

    lat = location_info[:geometry][:location][:lat]
    long = location_info[:geometry][:location][:lng]


  end
end
