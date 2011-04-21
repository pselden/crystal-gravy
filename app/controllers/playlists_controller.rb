class PlaylistsController < ApplicationController
  def new

  end
  
  def index
    
  end

  def show
	  @playlist = Playlist.find(params[:id])
    respond_with(@playlist)
  end

end
