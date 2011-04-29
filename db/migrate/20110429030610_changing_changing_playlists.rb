class ChangingChangingPlaylists < ActiveRecord::Migration
  def self.up
		rename_column :playlists, :name, :titlename
		add_column :playlists,  :descriptiontext, :string
		add_column :playlists,  :imageuri, :string
		add_column :playlists,  :mediacountvalue, :integer
  end

  def self.down
  end
end
