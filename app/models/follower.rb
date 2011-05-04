# == Schema Information
# Schema version: 20110504050645
#
# Table name: followers
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  follower_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Follower < ActiveRecord::Base
  set_table_name "followers"

  belongs_to :user
  belongs_to :follower, :class_name => "User"
end
