class ChangeVanityToUsername < ActiveRecord::Migration
  def self.up
    rename_column :users, :vanity, :username
  end

  def self.down
    #rename_column :users, :username, :vanity
  end
end
