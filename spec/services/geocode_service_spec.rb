require 'rails_helper'

describe GeocodeService do
  context 'instance methods' do
    context '#coords(location)' do
      it 'returns location latitude and longitude coordinates', :vcr do
        search = subject.coords('denver colorado')

        expect(search).to be_a Hash
        expect(search[:lat]).to eq(39.7392358)
        expect(search[:lng]).to eq(-104.990251)
      end
    end

    context '#address(location)' do
      it 'returns city, state and country name', :vcr do
        search = subject.address('denver colorado')

        expect(search).to be_an Array
        expect(search[0]).to be_a Hash
        expect(search[0][:long_name]).to eq('Denver')
        expect(search[2]).to be_a Hash
        expect(search[2][:short_name]).to eq('CO')
        expect(search[3]).to be_a Hash
        expect(search[3][:long_name]).to eq('United States')
      end
    end
  end
end
