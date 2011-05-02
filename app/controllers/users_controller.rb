class UsersController < ApplicationController

  def show
    append_javascript('follow')
    @user = User.find_by_id(params[:id], :include => [:followers, :following, :playlists])
    @title = @user.name
    result = @user.as_json(:include => [:followers, :following, :playlists])
    result["user"].merge!(:is_owner => owner?(params[:id]), :is_following => signed_in? ? current_user.following?(@user) : false)
    respond_with(result)
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