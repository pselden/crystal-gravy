CrystalGravy::Application.routes.draw do

  get "search/show"
  get "browse/playlist"

  resources :users
  resources :playlists
  resources :songs

  match "/playlists/:playlistName" => "playlists#show"
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => "pages#home"

end
