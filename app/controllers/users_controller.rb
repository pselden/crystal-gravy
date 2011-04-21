class UsersController < ApplicationController
  def show
    @user = User.find(params[:id], :select => "id, name, image")
    @title = @user.name
    @playlists = Array.new
    @user.playlists.find(:all, :select => "playlists.id, playlists.name").each do |playlist|
      @playlists << {
        "id" => playlist.id,
        "name" => playlist.name
      }
    end
    respond_with(:user => {:name => @user.name, :image => @user.image, :playlists => @playlists, :is_owner => owner?(params[:id])})
  end
end
