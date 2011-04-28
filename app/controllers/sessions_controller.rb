class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if @user
      sign_in @user
    else
      @user =  User.new_with_omniauth(auth)
    end
    render :layout => false
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
