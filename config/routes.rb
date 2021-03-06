CrystalGravy::Application.routes.draw do

  get "search/show"
  get "browse/playlist"

  resources :users
  resources :playlists
  resources :songs
  resources :profiles
  resources :relationships, :only => [:create]
  delete "relationships" => "relationships#destroy"
  
  match "users/:id/followers" => "users#followers"
  match "users/:id/following" => "users#following"
  match "profile/edit" => "profiles#edit"
  match "/playlists/create" => "playlists#create"
	match "/playlists/update" => "playlists#update"
	match "/playlists/:playlistName/destroy" => "playlists#destroy"
  match "/playlists/:playlistName" => "playlists#show"  
  match "/playlists/:playlistName/edit" => "playlists#edit"

	
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => "pages#home"

end
