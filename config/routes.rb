Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#index'
      get '/backgrounds', to: 'backgrounds#index'
      get '/gifs', to: 'gifs#index'
    end
  end
end
