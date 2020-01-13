require 'rails_helper'

describe DarkskyService do
  context 'instance methods' do
    context '#current(lat, long)' do
      it 'returns current forecast data' do
        darksky_json_response = File.read('spec/fixtures/darksky_forecast_data.json')
        darksky_uri = "https://api.darksky.net/forecast/#{ENV['DARKSKY_KEY']}/39.7392358,-104.990251"

        stub_request(:get, darksky_uri).to_return(status: 200, body: darksky_json_response)

        search = subject.current('39.7392358', '-104.990251')

        expect(search).to be_a Hash
        expect(search).to have_key(:time)
        expect(search).to have_key(:temperature)
        expect(search).to have_key(:apparentTemperature)
        expect(search).to have_key(:icon)
        expect(search).to have_key(:humidity)
        expect(search).to have_key(:visibility)
        expect(search).to have_key(:uvIndex)
      end
    end

    context '#hourly(lat, long)' do
      it 'returns hourly forecast data' do
        darksky_json_response = File.read('spec/fixtures/darksky_forecast_data.json')
        darksky_uri = "https://api.darksky.net/forecast/#{ENV['DARKSKY_KEY']}/39.7392358,-104.990251"

        stub_request(:get, darksky_uri).to_return(status: 200, body: darksky_json_response)

        search = subject.daily('39.7392358', '-104.990251')

        expect(search).to be_a Hash
        expect(search).to have_key(:summary)
        expect(search).to have_key(:temperatureHigh)
        expect(search).to have_key(:temperatureLow)
        expect(search).to have_key(:icon)
        expect(search).to have_key(:precipProbability)
        expect(search).to have_key(:precipType)
      end
    end

    context '#hourly(lat, long)' do
      it 'returns hourly forecast data' do
        darksky_json_response = File.read('spec/fixtures/darksky_forecast_data.json')
        darksky_uri = "https://api.darksky.net/forecast/#{ENV['DARKSKY_KEY']}/39.7392358,-104.990251"

        stub_request(:get, darksky_uri).to_return(status: 200, body: darksky_json_response)

        search = subject.hourly('39.7392358', '-104.990251')

        expect(search).to be_a Hash
        expect(search).to have_key(:summary)
        expect(search).to have_key(:icon)
        expect(search).to have_key(:temperature)
      end
    end
  end
end