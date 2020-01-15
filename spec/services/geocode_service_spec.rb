require 'rails_helper'

describe GeocodeService do
  context 'instance methods' do
    context '#geocode_data' do
      it 'returns location data for a specific location', :vcr do
        search = subject.geocode_data('denver colorado')

        expect(search).to be_a Hash

        expect(search[:address_components][0][:long_name]).to eq('Denver')
        expect(search[:address_components][2][:short_name]).to eq('CO')
        expect(search[:address_components][3][:long_name]).to eq('United States')

        expect(search[:geometry][:location][:lat]).to eq(39.7392358)
        expect(search[:geometry][:location][:lng]).to eq(-104.990251)
      end
    end
  end
end
