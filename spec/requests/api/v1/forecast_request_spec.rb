require 'rails_helper'

describe 'Forecast API' do
  it 'returns weather data for a given location' do
    geocode_url = "https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['GEOCODE_KEY']}"
    darksky_url = "https://api.darksky.net/forecast/#{ENV['DARKSKY_KEY']}/39.7392358,-104.990251"
    geocode_json_response = File.read('spec/fixtures/geocode_location_data.json')
    darksky_json_response = File.read('spec/fixtures/darksky_forecast_data.json')

    stub_request(:get, geocode_url).to_return(status: 200, body: geocode_json_response)
    stub_request(:get, darksky_url).to_return(status: 200, body: darksky_json_response)

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
  end
end
