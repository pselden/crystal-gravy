class User < ActiveRecord::Base
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
