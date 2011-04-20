class CreateAlbumTracks < ActiveRecord::Migration
  def self.up
    create_table :album_tracks do |t|
      t.integer :song_id
      t.integer :album_id
      t.integer :track_num

      t.timestamps
    end
  end

  def self.down
    drop_table :album_tracks
  end
end
