class Following < ActiveRecord::Base
	set_table_name "followings"
  belongs_to :user
end