class AntipodeFacade
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
  end

  private

    attr_reader :location
end
