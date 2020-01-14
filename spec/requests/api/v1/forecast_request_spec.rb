require 'rails_helper'

describe 'Forecast API' do
  it 'returns weather data for a given location' do

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
  end
end
