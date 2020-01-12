class BackgroundFacade
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
  end

  def image_uri
    UnsplashService.new.image(location)
  end

  private
    attr_reader :location
end
