class RenameUsersPlaylistsTable1 < ActiveRecord::Migration
  def self.up
		rename_table :user_playlist, :user_playlists
  end

  def self.down
  end
end
