require 'rails_helper'

describe UnsplashService do
  context 'instance methods' do
    context '#image(location)' do
      it 'returns the image uri for a location' do
        unsplash_json_response = File.read('spec/fixtures/unsplash_image_data.json')
        unsplash_uri = ("https://api.unsplash.com/search/photos?client_id=#{ENV['UNSPLASH_KEY']}&query=denver,co")

        stub_request(:get, unsplash_uri).to_return(status: 200, body: unsplash_json_response)

        search = subject.image('denver,co')
        image_uri = 'https://images.unsplash.com/photo-1546156929-a4c0ac411f47?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExMDE5MH0'

        expect(search).to eq(image_uri)
      end
    end
  end
end
