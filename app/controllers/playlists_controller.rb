class PlaylistsController < ApplicationController
  def new
		@template = "playlists/playlistform"
		append_javascript('playlist')
		respond_with(:form => { :header => "New playlist"  } )
  end
	
	def edit
	  #TODO: add playlist id, fill the form with playlist data
		@template = "playlists/playlistform"
		respond_with(:form => { :header => "New playlist" } )
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
		@playlist = Playlist.new(:name  => params[:name])
		if @playlist.save
			current_user.playlists << @playlist
			#respond_with(:form => {:header => "New playlist", :token => form_authenticity_token() } , :location => new_playlist_path)
		else
			#respond_with(:form => {:header => "New playlist", :token => form_authenticity_token() } , :location => new_playlist_path)
		end

	end

end
