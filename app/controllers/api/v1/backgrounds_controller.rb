class Api::V1::BackgroundsController < ApplicationController
  def show
    location = params[:location]
    background_image = BackgroundFacade.new(location)
    render json: BackgroundSerializer.new(background_image)
  end
end
