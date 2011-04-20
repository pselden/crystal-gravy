module SessionsHelper
	def signed_in?
		!current_user.nil?
	end

	 def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end

   def owner?(user_id)
     if signed_in?
       if user_id.is_a? Integer
         user_id == current_user.id ? true : false
       else
         user_id == current_user.id.to_s ? true : false
       end
     end
   end

end
