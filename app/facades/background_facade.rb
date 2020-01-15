class BackgroundFacade
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
  end

  def image_data
    @image_data ||= UnsplashService.new.image_data(location)
  end

  def image_uri
    image_data[0][:urls][:raw]
  end

  private

    attr_reader :location
end
