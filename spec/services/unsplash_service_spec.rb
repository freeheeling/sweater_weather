require 'rails_helper'

describe UnsplashService do
  context 'instance methods' do
    context '#image(location)' do
      it 'returns the image uri for a location', :vcr do
        search = subject.image('denver,co')
        image_uri = 'https://images.unsplash.com/photo-1570585429632-e8b74372a3ed?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjExMDE5MH0'

        expect(search).to eq(image_uri)
      end
    end
  end
end
