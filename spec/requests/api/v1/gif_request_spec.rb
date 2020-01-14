require 'rails_helper'

describe 'Giphy API' do
  it 'returns a forecast-related gif' do

    get '/api/v1/gifs?location=denver,co'

    expect(response).to be_successful
  end
end
