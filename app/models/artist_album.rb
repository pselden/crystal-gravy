# == Schema Information
# Schema version: 20110504050645
#
# Table name: artist_album
#
#  id         :integer         not null, primary key
#  artist_id  :integer
#  album_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class ArtistAlbum < ActiveRecord::Base
  belongs_to :artist
	belongs_to :album
end
