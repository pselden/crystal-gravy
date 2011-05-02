class Follower < ActiveRecord::Base
  set_table_name "followers"

  belongs_to :user
  belongs_to :follower, :class_name => "User"
end
