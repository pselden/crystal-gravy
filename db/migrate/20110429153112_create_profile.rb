class CreateProfile < ActiveRecord::Migration
  def self.up
    create_table :profile do |t|
      t.integer :user_id
      t.string :bio

      t.timestamps
    end
  end

  def self.down
    drop_table :profile
  end
end
