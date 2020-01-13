class AntipodeSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :type,
             :location_name,
             :summary,
             :current_temperature,
             :search_location
end
