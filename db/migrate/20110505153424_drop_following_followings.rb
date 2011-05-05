class DropFollowingFollowings < ActiveRecord::Migration
  def self.up
    drop_table "FOLLOWERS"
    drop_table "FOLLOWINGS"
  end

  def self.down
  end
end
