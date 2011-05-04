class ProfilesController < ApplicationController

  def edit
    append_javascript('edit_profile')
    @profile = Profile.find_by_user_id(current_user.id, :select => "bio, website")
    respond_with(@profile)
  end

  def create
    @profile = current_user.build_profile({:bio => params['bio'], :website => params['website']})
    if @profile.save
      @result = { :error => false }
    else
      if @profile.errors.any?
        @result = { :error => true, :errors => @profile.errors }
      end
    end
    respond_to do |format|
      format.json { render :json => @result.to_json }
    end
  end

  def update
    @profile = Profile.find_by_user_id(current_user.id)
    @profile.attributes = {:bio => params['bio'], :website => params['website']}
    if @profile.save
      @result = { :error => false }
    else
      if @profile.errors.any?
        @result = { :error => true, :errors => @profile.errors }
      end
    end
    respond_to do |format|
      format.json { render :json => @result.to_json }
    end
  end
  
end