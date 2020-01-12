require 'rails_helper'

describe 'Image API' do
  it 'returns a background image for a given location' do
    unsplash_uri = ("https://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_KEY']}&query=denver,co")
    unsplash_json_response = File.read('spec/fixtures/unsplash_image_data.json')

    stub_request(:get, unsplash_uri).to_return(status: 200, body: unsplash_json_response)

    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful
  end
end
