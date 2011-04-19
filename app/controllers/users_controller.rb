class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end
end
