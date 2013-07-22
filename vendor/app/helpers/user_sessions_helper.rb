module UserSessionsHelper
	def login_as(user)
		session[:user_id] = user.id
		self.current_user= user
	end

	def current_user=(user)
		@current_user = user
	end

	def login?
		!current_user.nil?
	end

	def current_user
		@current_user ||= login_from_session
	end

	def current_user?(user)
		user == current_user
	end

	def login_from_session
		if session[:user_id].present?
			begin 
				User.find(session[:user_id])	
			rescue
				session[:user_id] = nil
			end
		end
	end

	def logout
		session[:user_id] = nil
		current_user= nil
	end

	def need_sign_in
		unless login?
			redirect_to '/', :notice => 'You Need Sign In'
		end
	end

end
