class Profile < ActiveRecord::Base
  belongs_to :user

  validates :bio, :length => { :within => 1..140 }
end
