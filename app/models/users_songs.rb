# == Schema Information
# Schema version: 20110419175921
#
# Table name: users_songs
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  song_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class UsersSongs < ActiveRecord::Base
end
