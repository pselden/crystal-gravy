# == Schema Information
# Schema version: 20110504050645
#
# Table name: artist_song
#
#  id         :integer         not null, primary key
#  artist_id  :integer
#  song_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class ArtistSong < ActiveRecord::Base
  belongs_to :artist
	belongs_to :song
end
