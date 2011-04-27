class BrowseController < ApplicationController

  
  class Playlist
    
    attr_accessor:cover,:name,:author,:follow
    
    def initialize(cover,name,author,follow)
      @cover = cover
      @name = name
      @author = author
      @follow = follow
    end
    
  end
             
  def playlist
    append_stylesheet "browse/playlist"
        
    @sort = params[:sort] == nil ? "name"  : params[:sort] 
    
    @playlist = [];
    
    @playlist.unshift(Playlist.new("Cover","Mixtape Name 1","KCRW",true),
                      Playlist.new("Cover","Mixtape Name 7","JHJ DHDJH",true),
                      Playlist.new("Cover","Mixtape Name 8","QYQ SUYS",true),
                      Playlist.new("Cover","Mixtape Name 4","Bobby Solomon",true),
                      Playlist.new("Cover","Mixtape Name 5","QWRR",true),
                      Playlist.new("Cover","Mixtape Name 6","ABCDEFG SJ",true),
                      Playlist.new("Cover","Mixtape Name 2","John Bently",true),
                      Playlist.new("Cover","Mixtape Name 3","KXLU",true)
                    )
    
    
    @playlist.sort! {|a,b| a.send(@sort) <=> b.send(@sort) }
    
    respond_with({:playlist => @playlist})
  end

end
