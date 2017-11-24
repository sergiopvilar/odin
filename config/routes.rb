Rails.application.routes.draw do
  # Pages
  get '/', to: 'pages#root'
  get '/changelog', to: 'pages#changelog'

  # Autocomplete
  get '/items/autocomplete/:s', to: 'autocomplete#items'
  get '/mobs/autocomplete/:s', to: 'autocomplete#mobs'
  get '/maps/autocomplete/:s', to: 'autocomplete#maps'

  # Search
  get '/items/search', to: 'items#search'
  get '/mobs/search', to: 'mobs#search'

  # Images
  get '/image/map/:name', to: 'images#map'
  get '/image/mob/:id', to: 'images#mob'
  get '/image/item/:id', to: 'images#item'
  get '/image/item_big/:id', to: 'images#item_big'

  # Resources
  resources :mobs, only: [:show]
  resources :items, only: [:show]
  resources :maps, only: [:show]
end
