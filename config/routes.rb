Rails.application.routes.draw do
  resources :mobs, only: [:show]
  resources :items, only: [:show]

  # Pages
  get '/', to: 'pages#root'
  get '/changelog', to: 'pages#changelog'

  # Autocomplete
  get '/items/autocomplete/:s', to: 'autocomplete#items'
  get '/mobs/autocomplete/:s', to: 'autocomplete#mobs'

  # Images
  get '/image/mob/:id', to: 'images#mob'
  get '/image/item/:id', to: 'images#item'
  get '/image/item_big/:id', to: 'images#item_big'
end
