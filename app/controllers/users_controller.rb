class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    respond_with(:user => {:name => @user.name, :image => @user.image, :is_owner => owner?(params[:id]) })
  end
end
