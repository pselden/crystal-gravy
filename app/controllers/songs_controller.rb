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
    respond_with(:songs => @songs)
  end

  def show
    @song = Song.find(params[:id], :select => 'id, title')
  end

  def new
  end

end
