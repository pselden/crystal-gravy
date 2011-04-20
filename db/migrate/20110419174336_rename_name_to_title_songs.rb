class RenameNameToTitleSongs < ActiveRecord::Migration
  def self.up
	rename_column :songs, :name, :title
  end

  def self.down
  end
end
