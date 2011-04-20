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

class PlaylistTracks < ActiveRecord::Base
	attr_accessible :track_num
	belongs_to :playlists
	belongs_to :songs
end
