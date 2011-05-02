class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:followed_id])
    current_user.follow!(user)
    respond_to do |format|
      format.json { render :json => user }
    end
  end

  def destroy
    user = User.find(params[:followed_id])
    current_user.unfollow!(user)
    respond_to do |format|
      format.json { render :json => {:message => "Success!"} }
    end
  end
end