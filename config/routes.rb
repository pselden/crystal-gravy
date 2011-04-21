CrystalGravy::Application.routes.draw do

  resources :users
	resources :playlists

  match "/playlists/create" => "playlists#create"
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => "pages#home"

end
