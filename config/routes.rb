CrystalGravy::Application.routes.draw do

  resources :users
  resources :playlists

  get "playlists/new"

  get "songs/new"

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => "pages#home"

end
