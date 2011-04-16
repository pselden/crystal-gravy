class PlaylistsController < ApplicationController
  def new
	
  end
  
  def show
	@playlist = Playlist.find(params[:id])
	@title = @playlist.name
  end

end
