class FollowingsController < ApplicationController

  def create
    if current_user.following?(params[:following_id])
      @result = { :message =>'Already following user' }
    else
      current_user.follow!(params[:following_id])
      @result = { :message =>'Success' }
    end
    respond_to do |format|
      format.json { render :json => @result.to_json }
    end
  end

  def destroy
    if current_user.following?(params[:following_id])
      current_user.unfollow!(params[:following_id])
      @result = { :message =>'Success' }
    else
      @result = { :message =>'Already not following user' }
    end
    respond_to do |format|
      format.json { render :json => @result.to_json }
    end
  end
  
end
