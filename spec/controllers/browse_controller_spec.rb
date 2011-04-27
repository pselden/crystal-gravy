require 'spec_helper'

describe BrowseController do

  describe "GET 'playlist'" do
    it "should be successful" do
      get 'playlist'
      response.should be_success
    end
  end

end
