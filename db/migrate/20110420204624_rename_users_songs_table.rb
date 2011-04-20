class RenameUsersSongsTable < ActiveRecord::Migration
  def self.up
		rename_table :users_songs, :user_song
  end

  def self.down
  end
end
