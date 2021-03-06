# == Schema Information
# Schema version: 20110419175921
#
# Table name: album_tracks
#
#  id         :integer         not null, primary key
#  song_id    :integer
#  album_id   :integer
#  track_num  :integer
#  created_at :datetime
#  updated_at :datetime
#

class AlbumTrack < ActiveRecord::Base
	set_table_name "album_tracks"
	attr_accessible :track_num
	belongs_to :album
	belongs_to :song
end
