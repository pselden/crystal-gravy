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
	attr_accessible :name, :playlist_num
	has_many  :playlist_tracks
	has_many  :songs, :through => :playlist_tracks
	has_many  :users_playlists
	has_many  :users, :through => :users_playlists
	
	validates :name, :presence => true,
							:length      => { :maximum => 50 }



end
