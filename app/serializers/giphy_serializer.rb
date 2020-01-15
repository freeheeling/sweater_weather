class GiphySerializer
  include FastJsonapi::ObjectSerializer

  attributes :images
  attribute :copyright do
    "2019"
  end
end
