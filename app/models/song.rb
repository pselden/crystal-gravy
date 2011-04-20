# == Schema Information
# Schema version: 20110419175921
#
# Table name: songs
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Song < ActiveRecord::Base
	attr_accessible :title
	has_many  :playlists, :through => :playlist_tracks
	has_many  :albums, :through => :album_tracks
	
	validates :title, :presence => true,
							:length      => { :maximum => 100 }
end
