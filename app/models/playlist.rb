# == Schema Information
# Schema version: 20110419175921
#
# Table name: playlists
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Playlist < ActiveRecord::Base
  include PlaylistsHelper

	set_table_name "playlists"
	has_many  :playlist_tracks
	has_many  :songs, :through => :playlist_tracks
	has_many  :user_playlists
	has_many  :users, :through => :user_playlists
	
	validates :titlename, :presence => true,
							:length      => { :within => 1..255 }

  def url
    playlist_url(titlename, id)
  end

  def serializable_hash(options)
    options ||= {}
    options.merge!(:methods => [:url])
    super(options)
  end
end
