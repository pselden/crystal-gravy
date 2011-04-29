CrystalGravy::Application.routes.draw do

  get "browse/playlist"

  resources :users
  resources :playlists
  resources :songs

  match "/followings/create" => "followings#create"
  match "/followings/destroy" => "followings#destroy"
  match "/playlists/:playlistName" => "playlists#show"
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => "pages#home"

end
