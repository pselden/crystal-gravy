# == Schema Information
# Schema version: 20110504050645
#
# Table name: profile
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  bio        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Profile < ActiveRecord::Base
  belongs_to :user

  validates :bio, :length => { :within => 1..140 }
end
