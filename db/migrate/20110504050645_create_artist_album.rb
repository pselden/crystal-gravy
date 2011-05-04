class CreateArtistAlbum < ActiveRecord::Migration
  def self.up
    create_table :artist_album do |t|
      t.integer :artist_id
      t.integer :album_id

      t.timestamps
    end
  end

  def self.down
    drop_table :artist_album
  end
end
