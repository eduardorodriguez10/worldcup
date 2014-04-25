class SessionsController < ApplicationController
	def new

	end

	def create
		user = User.find_by(email: params[:email])
		unless user.nil? 
			bracket = Bracket.find_by(user_id: user.id)
		end
		if user && user.authenticate(params[:password])
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

	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
end