# == Schema Information
# Schema version: 20110419175921
#
# Table name: playlist_tracks
#
#  id          :integer         not null, primary key
#  playlist_id :integer
#  song_id     :integer
#  track_num   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class PlaylistTrack < ActiveRecord::Base
	set_table_name "playlist_tracks"
	attr_accessible :track_num
	belongs_to :playlist
	belongs_to :song
end
