class PlaylistsController < ApplicationController
  def new
	
  end
  
  def show
	@playlist = Playlist.find(params[:id])
  end

end
