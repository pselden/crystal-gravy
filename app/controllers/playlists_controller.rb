class PlaylistsController < ApplicationController
  def new

  end
  
  def index
    @playlist = Playlist.all
    respond_with(@playlist)
  end

  def show
	  @playlist = Playlist.find(params[:id])
    respond_with(@playlist)
  end

end
