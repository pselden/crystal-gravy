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
  attr_accessible :provider, :uid, :name, :image, :username
	has_many  :user_playlists
	has_many  :playlists, :through => :user_playlists
	has_many  :albums
	has_and_belongs_to_many :songs

  validates :username, :uniqueness => true, :length => { :within => 2..64 }
	
  def self.find_and_update_with_omniauth(auth)
    user = find_by_provider_and_uid(auth["provider"], auth["uid"].to_s)
    if user
      user.name = auth["user_info"]["name"]
      user.image = auth["user_info"]["image"]
      user.save!
    end
    user
  end

  def self.new_with_omniauth auth
    user = User.new
    user.uid = auth["uid"]
    user.provider = auth["provider"]
    user.name = auth["user_info"]["name"]
    user.image = auth["user_info"]["image"]
    user.username = auth["user_info"]["nickname"]
    user
  end

end
