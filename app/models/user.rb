# == Schema Information
# Schema version: 20110419175921
#
# Table name: users
#
#  id         :integer         not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#

class User < ActiveRecord::Base
	has_many  :user_playlists
	has_many  :playlists, :through => :user_playlists
	has_many  :albums
  has_many :followings
  has_many :followers
	has_and_belongs_to_many :songs

  #validates :username, :on => :create, :uniqueness => true, :length => { :within => 2..64 }
	
  def self.find_or_create_or_update_with_omniauth(auth)
    user = find_by_provider_and_uid(auth["provider"], auth["uid"].to_s) || User.new
    user.uid = auth["uid"]
    user.provider = auth["provider"]
    user.name = auth["user_info"]["name"]
    user.image = auth["user_info"]["image"]
    user.save!
    user
  end

  def follow!(following_id)
    followings.create!(:following_id => following_id)
  end

  def following?(following_id)
    followings.find_by_following_id(following_id) ? true : false
  end

  def unfollow!(following_id)
    followings.find_by_following_id(following_id).destroy
  end

end
