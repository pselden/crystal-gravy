class UsersController < ApplicationController

  def show
    append_javascript('follow')
    @user = User.find(params[:id], :select => "id, name, image")
    @title = @user.name
    #get playlists
    @playlists = Array.new
    @user.playlists.find(:all, :select => "playlists.id, playlists.titlename").each do |playlist|
      @playlists << {
        "id" => playlist.id,
        "name" => playlist.titlename,
        "url" => playlist_url(playlist.titlename, playlist.id)
      }
    end
    #get followers
    @followers = Array.new
    @user.followers.find(:all, :select => "follower_id").each do |follower|
      follower = User.find_by_id(follower.follower_id, :select => "id, name, image")
      @followers << {
        "id" => follower.id,
        "name" => follower.name,
        "image" => follower.image
      }
    end
    #get following
    @following = Array.new
    @user.followings.find(:all, :select => "following_id").each do |following|
      following = User.find_by_id(following.following_id, :select => "id, name, image")
      @following << {
        "id" => following.id,
        "name" => following.name,
        "image" => following.image
      }
    end

    respond_with(:user => {:id => @user.id, :name => @user.name, :image => @user.image, :playlists => @playlists, :followers => @followers.empty? ? nil : @followers, :followings => @following.empty? ? nil : @following, :is_owner => owner?(params[:id]), :following => signed_in? ? current_user.following?(@user.id) : false})
  end

  def edit
    if signed_in?
      append_javascript('edit_user')
      if owner?(params[:id])
        respond_with(:user => {:id => current_user.id, :name => current_user.name, :username => current_user.username})
      else
        #this should be through sammy, one day.
        redirect_to edit_user_path(current_user.id)
      end
    else
      #redirect to signin?
    end
  end

  def create
    @user = User.create(params[:user])
    sign_in @user
    if @user.errors.any?
      render :json => {:errors => @user.errors }
    else
      respond_to do |format|
        format.json { render :json => @user }
        format.any { redirect_to root_path }
      end
    end
  end

end