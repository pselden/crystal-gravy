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
	has_many  :playlists, :through => :users_playlists
	has_many  :albums
	has_and_belongs_to_many :songs
	
  def self.find_or_create_or_update_with_omniauth(auth)
    user = find_by_provider_and_uid(auth["provider"], auth["uid"].to_s) || User.new
    user.uid = auth["uid"]
    user.provider = auth["provider"]
    user.name = auth["user_info"]["name"]
    user.image = auth["user_info"]["image"]
    user.save!
    user
  end
end
