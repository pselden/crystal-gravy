# == Schema Information
# Schema version: 20110504050645
#
# Table name: player_queue
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  song_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class PlayerQueue < ActiveRecord::Base
  belongs_to :user
	belongs_to :song
end
