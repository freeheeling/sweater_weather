class GiphySerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :time,
             :summary,
             :url
end
