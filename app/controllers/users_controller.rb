class UsersController < ApplicationController
	def new
		if(params.has_key?(:email) && params.has_key?(:passcode))
			if(user_attempt_exists?(params[:email]))
				attempt = RegisterAttempt.find_by(email: params[:email])
				if(attempt.passcode == params[:passcode])
					@user = User.new
					@user.email = params[:email]
				else
					redirect_to attempt_path
				end
			else
				redirect_to attempt_path
			end
		else
			redirect_to attempt_path
		end
	end

	def create
	@user = User.new(user_params)
	@user.admin = false
	@user.admin_view = false
		if @user.save
			session[:user_id] = @user.id 
			flash[:notice] = "Welcome to World Cup Bracket, You are registered now."
			redirect_to new_bracket_path()
		else
			flash[:error] = @user.errors
			redirect_to '/register'
		end
	end

	def show
		@user = User.find(session[:user_id])
	end

	def edit
		@user = User.find(session[:user_id])
	end

	def update
		@user = User.find(session[:user_id])
		if(params[:user].has_key?(:password))
			if(@user.authenticate(params[:oldpassword]))
				if@user.update(user_params)
					flash[:notice] = "Your password has been changed."
					redirect_to edit_user_path(@user)
				else
					flash[:error] = "There was a problem updating your account."
					redirect_to edit_user_path(@user)
				end
			else
					flash[:error] = "Incorrect current password."
					redirect_to edit_user_path(@user)
			end
		else
			if @user.update(user_params)
				flash[:notice] = "Your account was updated successfuly"
				redirect_to edit_user_path(@user)
			else
				flash[:error] = "There was a problem updating your user account."
				redirect_to edit_user_path(@user)
			end
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :country, :first_name, :last_name, :screenname)
	end
end