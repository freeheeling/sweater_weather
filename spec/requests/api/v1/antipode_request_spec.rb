require 'rails_helper'

describe 'Antipode' do
  it 'returns the antipode city and forecast' do
    city = 'hong kong'
    geocode_uri = "https://maps.googleapis.com/maps/api/geocode/json?address=#{city}&key=#{ENV['GEOCODE_KEY']}"
    amypode_uri = 'http://amypode.herokuapp.com/api/v1/antipodes?lat=22.3193039&long=114.1693611'
    reverse_geocode_uri = "https://maps.googleapis.com/maps/api/geocode/json?latlng=-22.3193039,-65.8306389&key=#{ENV['GEOCODE_KEY']}"
    darksky_uri = "https://api.darksky.net/forecast/#{ENV['DARKSKY_KEY']}/-22.3193039,-65.8306389"

    geocode_json_response = File.read('spec/fixtures/geocode_location_data.json')
    amypode_json_response = File.read('spec/fixtures/amypode_location_data.json')
    reverse_geocode_json_response = File.read('spec/fixtures/reverse_geocode_location_data.json')
    darksky_json_response = File.read('spec/fixtures/darksky_forecast_data.json')

    stub_request(:get, geocode_uri).to_return(status: 200, body: geocode_json_response)
    stub_request(:get, amypode_uri).to_return(status: 200, body: amypode_json_response)
    stub_request(:get, reverse_geocode_uri).to_return(status: 200, body: reverse_geocode_json_response)
    stub_request(:get, darksky_uri).to_return(status: 200, body: darksky_json_response)

    get "/api/v1/antipode?location=#{city}"

    expect(response).to be_successful
  end
end
