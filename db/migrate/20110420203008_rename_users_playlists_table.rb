class RenameUsersPlaylistsTable < ActiveRecord::Migration
  def self.up
		rename_table :users_playlists, :user_playlist
  end

  def self.down
  end
end
