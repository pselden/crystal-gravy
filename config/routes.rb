CrystalGravy::Application.routes.draw do
  
 match "/users/:id" => "users#show"
  
  resources :playlists
  get "playlists/new"

  get "songs/new"

  get "pages/home"
  get "pages/test"

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  root :to => "pages#home"

end
