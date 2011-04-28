require "spec_helper"

describe "create_with_omniauth" do

  before(:each) do
    @auth = { "provider"=> :facebook, "uid" => "0123456", "user_info" => { "name" => "Test User", "image" => "imageurl" }}
  end

  it "should create a new user with the username set as the user id" do
    user = User.create_with_omniauth(@auth)
    user.username.should == user.id.to_s
  end
end