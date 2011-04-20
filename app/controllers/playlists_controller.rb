class PlaylistsController < ApplicationController
  def new
	
  end
  
  def show
    @user = current_user
	  @playlist = Playlist.find(params[:id])
	  @title = @playlist.name
  end

end
