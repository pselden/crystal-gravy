class UsersController < ApplicationController
  def show
    @user = User.find(params[:id], :select => "id, name, image")
    @title = @user.name
    @playlists = Array.new
    @user.playlists.find(:all, :select => "playlists.id, playlists.name").each do |playlist|
      @playlists << {
        "id" => playlist.id,
        "name" => playlist.name,
        "url" => playlist_url(playlist.name, playlist.id)
      }
    end
    respond_with(:user => {:name => @user.name, :image => @user.image, :playlists => @playlists, :is_owner => owner?(params[:id])})
  end

  def edit
    if signed_in?
      if owner?(params[:id])
        respond_with(current_user)
      else
        #this should be through sammy, one day.
        redirect_to edit_user_path(current_user.id)
      end
    else
      #redirect to signin?
    end
  end

end
