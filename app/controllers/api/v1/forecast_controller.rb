class Api::V1::ForecastController < ApplicationController
  def index
    weather = params[:location]
    weather_data = ForecastFacade.new(weather)
    render json: ForecastSerializer.new(weather_data)
  end
end
