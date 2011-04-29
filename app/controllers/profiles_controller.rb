class ProfilesController < ApplicationController

  def edit
    append_javascript('edit_profile')
    @profile = Profile.find_by_user_id(current_user.id, :select => "bio")
    respond_with(@profile)
  end

  def create
    @profile = Profile.new(params[:edit_profile])
    if @profile.save
      @result = { :error => false }
#    else
      if @profile.errors.any?
        @result = { :error => true, :errors => @profile.errors }
      end
    end
     respond_to do |format|
      format.json { render :json => @result.to_json }
    end
  end
  
end