# == Schema Information
# Schema version: 20110420204624
#
# Table name: user_playlists
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  playlist_id  :integer
#  playlist_num :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class UserPlaylist < ActiveRecord::Base
	set_table_name "user_playlists"
	belongs_to :user
	belongs_to :playlist
end
