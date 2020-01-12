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

    # darksky
    conn = Faraday.new(url: 'https://api.darksky.net') do |f|
      f.adapter(Faraday.default_adapter)
    end

    response = conn.get("/forecast/#{ENV['DARKSKY_KEY']}/#{lat},#{long}")
    weather_data = JSON.parse(response.body, symbolize_names: true)

    current_date = weather_data[:currently][:time]
    current_temp = weather_data[:currently][:temperature]
    feels_like = weather_data[:currently][:apparentTemperature]
    current_icon = weather_data[:currently][:icon]
    humidity = weather_data[:currently][:humidity]
    visibility = weather_data[:currently][:visibility]
    uv_index = weather_data[:currently][:uvIndex]

    summary = weather_data[:daily][:data][0][:summary]
    daily_day = weather_data[:daily][:data][0][:time]
    daily_high = weather_data[:daily][:data][0][:temperatureHigh]
    daily_low = weather_data[:daily][:data][0][:temperatureLow]
    daily_icon = weather_data[:daily][:data][0][:icon]
    daily_precip_percent = weather_data[:daily][:data][0][:precipProbability]
    daily_precip_type = weather_data[:daily][:data][0][:precipType]

    hourly_icon = weather_data[:hourly][:data][0][:icon]
    hourly_time = weather_data[:hourly][:data][0][:time]
    hourly_temp = weather_data[:hourly][:data][0][:temperature]
  end
end
