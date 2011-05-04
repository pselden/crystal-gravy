class PluralizeArtistTable < ActiveRecord::Migration
  def self.up
    drop_table :artist
    create_table :artists do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
  end
end
