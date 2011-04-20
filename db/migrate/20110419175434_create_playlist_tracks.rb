class CreatePlaylistTracks < ActiveRecord::Migration
  def self.up
    create_table :playlist_tracks do |t|
      t.integer :playlist_id
      t.integer :song_id
      t.integer :track_num

      t.timestamps
    end
  end

  def self.down
    drop_table :playlist_tracks
  end
end
