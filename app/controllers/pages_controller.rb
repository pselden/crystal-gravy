class PagesController < ApplicationController
  def home
    @blog = {:title => "My awesome blog.", :body => "This is the body of the blog.", :author => {:name => "Paul Selden"}}
    respond_with({:blog => @blog})
  end

  def test
    @t = { :one => "This is a test of the emergency broadcast system.", :two => "hurray" }
    respond_with({:t => @t}, :partials => {:partial1 => "pages/sub/partial1", :partial2 => "shared/partial2"})
  end

end
