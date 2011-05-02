class Relationship < ActiveRecord::Base
  set_table_name "relationships"

  attr_accessible :followed_id

  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"

  validates :followed_id, :presence => true
  validates :follower_id, :presence => true
end
