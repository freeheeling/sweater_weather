require 'rails_helper'

describe 'Image API' do
  it 'returns a background image for a given location' do

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful
  end
end
