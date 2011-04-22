class PlaylistsController < ApplicationController
  def new
		respond_with(:form => {:header => "New playlist", :token => form_authenticity_token() } )
  end

  def index
    @playlist = Playlist.all
    respond_with(@playlist)
  end

  def show
	  @playlist = Playlist.find_by_id(id_from_url(params[:id]), :include => :songs)
    respond_with(:playlist => {"name" => @playlist.name, "songs" => @playlist.songs.empty? ? nil : @playlist.songs})
  end

	def create
		@playlist = Playlist.new(params[:title])
		@playlist.save
		respond_with(:form => {:header => "SAVED !!!! "} )
	end

end
