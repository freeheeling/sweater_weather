require 'rails_helper'

describe UnsplashService do
  context 'instance methods' do
    context '#image_data(location)' do
      it 'returns image data for a given location', :vcr do
        search = subject.image_data('denver,co')
        image_uri = 'https://images.unsplash.com/photo-1570585429632-e8b74372a3ed?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExMDE5MH0'

        expect(search).to be_an Array
        expect(search[0][:urls][:raw]).to eq(image_uri)
      end
    end
  end
end
