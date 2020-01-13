class AntipodeController < ApplicationController
  def index
    location = params[:location]
    antipode_data = AntipodeFacade.new(location)
    render json: AntipodeSerializer.new(antipode_data)
  end
end
