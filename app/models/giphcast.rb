class Giphcast
  attr_reader :time, :summary, :url, :id

  def initialize(time, summary, url)
    @time = time
    @summary = summary
    @url = url
    @id = nil
  end
end
