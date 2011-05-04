class CreateArtist < ActiveRecord::Migration
  def self.up
    create_table :artist do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :artist
  end
end
