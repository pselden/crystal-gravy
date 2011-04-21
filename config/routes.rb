CrystalGravy::Application.routes.draw do

  resources :users
  #resources :playlists

  match "/playlists" => "playlists#index"
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  root :to => "pages#home"

end
