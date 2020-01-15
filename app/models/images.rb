class Images
  attr_reader :images, :id

  def initialize(giphy_forecast)
    @images = giphy_forecast
    @id = nil
  end
end
