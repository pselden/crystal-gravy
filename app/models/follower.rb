class Follower < ActiveRecord::Base
  set_table_name "followers"
  belongs_to :user
end
