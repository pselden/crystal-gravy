CrystalGravy::Application.routes.draw do


  get "browse/playlist"

  resources :users
  resources :playlists
  resources :songs
  resources :profiles
  
  match "profile/edit" => "profiles#edit"

  match "/followings/create" => "followings#create"
  match "/followings/destroy" => "followings#destroy"
	
	match "/playlists/create" => "playlists#create"
  match "/playlists/:playlistName" => "playlists#show"
	
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => "pages#home"

end
