class SongsController < ApplicationController
  def index
    @songs = Array.new
    Song.find(:all, :include => :albums).each do |song|
      @songs << {
        'id' => song.id,
        'title' => song.title,
        'album' => song.albums[0].title
      }
    end
    if signed_in?
      @playlists = Array.new
      current_user.playlists.find(:all, :select => 'playlists.id, playlists.name').each do |playlist|
        @playlists << {
          "id" => playlist.id,
          "name" => playlist.name
        }
      end
    end
    respond_with(:songs => @songs, :user_playlists => @playlists)
  end

  def show
    @song = Song.find(params[:id], :select => 'id, title')
  end

  def new
  end

end
