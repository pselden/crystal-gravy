class AddWebsiteToProfile < ActiveRecord::Migration
  def self.up
    add_column :profile, :website, :string
  end

  def self.down
    remove_column :profile, :website
  end
end
