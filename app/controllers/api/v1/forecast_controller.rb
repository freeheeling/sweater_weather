class Api::V1::ForecastController < ApplicationController
  def index
    location = params[:location]
    weather_data = ForecastFacade.new(location)
    render json: ForecastSerializer.new(weather_data)
  end
end
