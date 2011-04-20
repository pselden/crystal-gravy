class CreateUsersPlaylists < ActiveRecord::Migration
  def self.up
    create_table :users_playlists do |t|
      t.integer :user_id
      t.integer :playlist_id
      t.integer :track_num

      t.timestamps
    end
  end

  def self.down
    drop_table :users_playlists
  end
end
