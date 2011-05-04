# == Schema Information
# Schema version: 20110504050645
#
# Table name: artist
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Artist < ActiveRecord::Base
  set_table_name "artists"
  has_many  :artist_song
	has_many  :songs, :through => :artist_song
  has_many  :artist_album
	has_many  :album, :through => :artist_album
end
