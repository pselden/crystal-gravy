# == Schema Information
# Schema version: 20110419175921
#
# Table name: albums
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  set_table_name "albums"
	attr_accessible :title
	has_many  :album_tracks
	has_many  :songs, :through => :album_tracks
	belongs_to  :users
	
	validates :title, :presence => true,
							:length      => { :maximum => 100 }
end
