class CreatePlayerQueue < ActiveRecord::Migration
  def self.up
    create_table :player_queue do |t|
      t.integer :user_id
      t.integer :song_id

      t.timestamps
    end
  end

  def self.down
    drop_table :player_queue
  end
end
