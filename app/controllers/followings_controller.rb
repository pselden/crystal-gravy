class FollowingsController < ApplicationController

  def create
    current_user.follow!(params[:following_id])
    respond_to do |format|
        format.json { 'success' }
    end
  end

  def destroy
    current_user.unfollow!(params[:following_id])
    respond_to do |format|
        format.json { 'success' }
    end
  end
  
end
