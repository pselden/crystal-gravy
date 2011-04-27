class AddVanityToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :vanity, :string, :unique => true
  end

  def self.down
    remove_column :users, :vanity
  end
end
