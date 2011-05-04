class CreateArtistSong < ActiveRecord::Migration
  def self.up
    create_table :artist_song do |t|
      t.integer :artist_id
      t.integer :song_id

      t.timestamps
    end
  end

  def self.down
    drop_table :artist_song
  end
end
