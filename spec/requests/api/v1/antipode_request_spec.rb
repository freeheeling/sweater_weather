require 'rails_helper'

describe 'Antipode' do
  it 'returns the antipode city and forecast' do
    get '/api/v1/antipode?location=city'

    expect(response).to be_successful
  end
end
