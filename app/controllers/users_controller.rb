class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    respond_with(:user => {:name => @user.name, :image => @user.image, :is_owner => signed_in? && current_user.id.to_s() == params[:id] ? true : false })
  end
end
