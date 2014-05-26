class SessionsController < ApplicationController
	def new

	end

	def create
		if(params.has_key?(:email))
			params[:email] = params[:email].downcase
			user = User.find_by(email: params[:email])
			if user && user.authenticate(params[:password])
				bracket = Bracket.find_by(user_id: user.id)
				session[:user_id] = user.id 
				if bracket.nil?
					redirect_to new_bracket_path()
				else
					redirect_to bracket_path(user.id)
				end
			else
				flash[:error] = "There's something wrong with your username or password"
				redirect_to login_path
			end
		else
			flash[:error] = "There's something wrong with your username or password"
			redirect_to login_path
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end

	def admin

	end

	def newadmin
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password]) && user.is_admin?
			session[:user_id] = user.id 
			redirect_to wcbmgmt_path
		else
			flash[:error] = "There's something wrong with your username or password"
			redirect_to login_path
		end
	end
end