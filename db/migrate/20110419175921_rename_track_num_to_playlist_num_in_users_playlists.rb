class RenameTrackNumToPlaylistNumInUsersPlaylists < ActiveRecord::Migration
  def self.up
	rename_column :users_playlists, :track_num, :playlist_num	
end

  def self.down
  end
end
