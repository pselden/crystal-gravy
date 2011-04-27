class PagesController < ApplicationController
  def home
    @blog = {:title => "My awesome blog.", :body => "This is the body of the blog.", :author => {:name => "Paul Selden"}}
    respond_with({:blog => @blog})
  end

end
