class PlaylistsController < ApplicationController
  def new
		@template = "playlistform"
		append_javascript('playlist')
		respond_with(:form => { :mode => "create", 
                            :id => '',
                            :header => "New playlist", 
                            :titlename => '', 
                            :descriptiontext => '' } )
  end
	
	def edit
		@template = "playlistform"
		append_javascript('playlist')
    @playlist = Playlist.find_by_id(id_from_url(params[:id]))
		respond_with(:form => { :mode => "update",
                            :id => @playlist.id,
                            :header => "Edit playlist", 
                            :titlename => @playlist.titlename, 
                            :descriptiontext => @playlist.descriptiontext } )
	end

  def index
    @playlist = Playlist.all
    respond_with(@playlist)
  end

  def show
    append_javascript('playlist')
	  @playlist = Playlist.find_by_id(id_from_url(params[:id]), :include => :songs)
    respond_with(:playlist => {"titlename" => @playlist.titlename, 
                              "descriptiontext" => @playlist.descriptiontext,
                              "editpath" => playlist_url(@playlist.titlename, @playlist.id) + "/edit",
                              "songs" => @playlist.songs.empty? ? nil : @playlist.songs})
  end

	def create
		@playlist = Playlist.new(:titlename  => params[:titlename], :descriptiontext => params[:descriptiontext])
		@result = { :error=> false, :message =>'' }
		if @playlist.save
			current_user.playlists << @playlist
			@result[:playlistpath] = playlist_url(@playlist.titlename, @playlist.id);
		else
      @result = { :error=> true, :message => 'An error has occured. Try again.' }
		end
		respond_with_json(@result)
	end
  
  def update
		@playlist = Playlist.find(id_from_url(params[:playlist_id]))
		@result = { :error=> false, :message =>'' }
		if @playlist.update_attributes(:titlename  => params[:titlename], :descriptiontext => params[:descriptiontext])
			@result[:playlistpath] = playlist_url(@playlist.titlename, @playlist.id);
		else
			@result = { :error=> true, :message => 'An error has occured. Try again.' }
		end
		respond_with_json(@result)
  end
	
	def destroy
		@playlist_id = params[:playlist_id]
		if  !current_user.has_playlist?(@playlist_id )
			current_user.delete_playlist!(@playlist_id )
		end
	end
	
	private 
		def respond_with_json(result)
	    respond_to do |format|
        format.json { render :json => result.to_json }
      end		
		end

end
