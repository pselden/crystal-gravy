class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_or_update_with_omniauth(auth)
    session[:user_id] = user.id
    render :layout => false
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
