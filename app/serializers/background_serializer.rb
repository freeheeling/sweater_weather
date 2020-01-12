class BackgroundSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :image_uri
end
