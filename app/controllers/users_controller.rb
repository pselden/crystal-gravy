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
        respond_with(:user => {:id => current_user.id, :name => current_user.name, :vanity => current_user.vanity})
      else
        #this should be through sammy, one day.
        redirect_to edit_user_path(current_user.id)
      end
    else
      #redirect to signin?
    end
  end

  def update
    user = User.find(params[:id])
    user.attributes = {:vanity => params[:vanity]}
    @result = { :error => false, :message => 'Success' }
    if user.save
      respond_to do |format|
        format.json { render :json => @result.to_json }
      end
		else
      @result = { :error => true, :message => 'An error has occured. Try again.' }
      if user.errors.any?
        @result = { :error => true, :message => 'An error has occured. Try again.', :errors => user.errors }
      end
      respond_to do |format|
        format.json { render :json => @result.to_json }
      end
		end
  end

end
