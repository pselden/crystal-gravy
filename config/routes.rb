CrystalGravy::Application.routes.draw do
  get "pages/home"
  get "pages/test"

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  root :to => "pages#home"

end
