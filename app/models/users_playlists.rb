# == Schema Information
# Schema version: 20110419175921
#
# Table name: users_playlists
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  playlist_id  :integer
#  playlist_num :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class UsersPlaylists < ActiveRecord::Base
	attr_accessible :playlist_num
	belongs_to :users	
	belongs_to :playlists
end
