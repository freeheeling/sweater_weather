class Api::V1::ForecastController < ApplicationController
  def show
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
    city = location_data[:results][0][:address_components][0][:long_name]
    state = location_data[:results][0][:address_components][2][:short_name]
    country = location_data[:results][0][:address_components][3][:long_name]
  end
end
