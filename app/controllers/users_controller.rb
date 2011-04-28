class UsersController < ApplicationController
  def show
    @user = User.find(params[:id], :select => "id, name, image")
    @title = @user.name
    @playlists = Array.new
    @user.playlists.find(:all, :select => "playlists.id, playlists.name").each do |playlist|
      @playlists << {
        "id" => playlist.id,
        "name" => playlist.name,
        "url" => playlist_url(playlist.name, playlist.id)
      }
    end
    respond_with(:user => {:id => @user.id, :name => @user.name, :image => @user.image, :playlists => @playlists, :is_owner => owner?(params[:id])})
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
