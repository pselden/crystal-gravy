class PlaylistsController < ApplicationController
  def new
		@template = "playlistform"
		append_javascript('playlist')
		respond_with(:form => { :header => "New playlist", :titlename => '', :descriptiontext => '' } )
  end
	
	def edit
	  #TODO: add playlist id, fill the form with playlist data
		@template = "playlistform"
		append_javascript('playlist')
		respond_with(:form => { :header => "Edit playlist", :titlename => '', :descriptiontext => '' } )
	end

  def index
    @playlist = Playlist.all
    respond_with(@playlist)
  end

  def show
	  @playlist = Playlist.find_by_id(id_from_url(params[:id]), :include => :songs)
    respond_with(:playlist => {"titlename" => @playlist.titlename, "descriptiontext" => @playlist.descriptiontext,  "songs" => @playlist.songs.empty? ? nil : @playlist.songs})
  end

	def create
		@playlist = Playlist.new(:titlename  => params[:titlename], :descriptiontext => params[:descriptiontext])
    @result = { :error=> false, :message =>'' }
		if @playlist.save
			current_user.playlists << @playlist
			@result[:playlistpath] = playlist_url(@playlist.titlename, @playlist.id);
      respond_to do |format|
        format.json { render :json => @result.to_json }
      end
		else
      @result = { :error=> true, :message => 'An error has occured. Try again.' }
      respond_to do |format|
        format.json { render :json => @result.to_json }
      end
		end

	end

end
