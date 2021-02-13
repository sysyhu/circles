module Concerns

	module UserSession
		def self.included base
			base.class_eval do
				helper_method :logged_in?
				helper_method :current_user
			end
		end


		#登录成功，设置当前用户的 session 的值;
		def signin_user user
			session[:user_id] = user.id
		end

		#退出，设置当前用户的 session 为 nill;
		def logout_user
			session[:user_id] = nil
		end

		#判断是否登录？
		def logged_in?
			!!session[:user_id] #得到 true 或者 false
		end

		#取得当前登录用户的对象;
		def current_user
			if logged_in?
				@current_user ||= User.find(session[:user_id])
			else
				nill
			end
		end
	end

end