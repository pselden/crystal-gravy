class UsersController < ApplicationController
  def show
    @user = User.find(params[:id], :include => :playlists)
    respond_with(:user => {:name => @user.name, :image => @user.image, :playlists => @user.playlists, :is_owner => owner?(params[:id])})
  end
end
