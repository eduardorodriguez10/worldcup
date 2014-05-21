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
		if(params.has_key?(:email) && params.has_key?(:passcode))
			if(user_password_recovery_exists?(params[:email], params[:passcode]))
				if(params[:user].has_key?(:password))
					@user_change = User.find_by(email: params[:email])
					@user_change.password = params[:user][:password]
					@user_change.recovery_attemps = 4
					if @user_change.save
						flash[:notice] = "Your password has been changed."
						redirect_to login_path
					else
						flash[:error] = "There was a problem updating your password."
						redirect_to login_path
					end
				else
					flash[:error] = "There was a problem updating your password."
					redirect_to login_path
				end
			else
				flash[:error] = "There was a problem updating your password."
				redirect_to login_path
			end
		else
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
	end

	def recover_password

	end

	def recover_password_email
		if valid_email?(params[:email])
			if(user_email_exists?(params[:email]))
				@user = User.find_by(email: params[:email])
				@user.password_recovery = generate_random_code
				@user.recovery_time = DateTime.now
				@user.recovery_attemps = 0
				@user.save
				@url = '/password_modify?email='+@user.email+'&passcode='+@user.password_recovery
				UserMailer.send_password_recovery(@user, @url).deliver
			   flash[:notice] = "Please check your email to update your password."
			   redirect_to login_path
			else 
				flash[:error] = "Could not find your email address in the system."
				redirect_to login_path
			end
		else
			flash[:error] = "Invalid Email Address. Please try again."
			redirect_to login_path
		end
	end

	def password_modify
		if(params.has_key?(:email) && params.has_key?(:passcode))
			if(user_password_recovery_exists?(params[:email], params[:passcode]))
				@user = User.find_by(email: params[:email])
				@passcode = params[:passcode]
				@email = params[:email]
			else
				redirect_to login_path
			end
		else
			redirect_to login_path
		end	
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :country, :first_name, :last_name, :screenname)
	end

	def user_password_recovery_exists?(email, passcode)
		user = User.find_by(email: email)
		if (user.nil?)
			return false
		elsif (user.password_recovery == passcode && (user.recovery_time > 2.hours.ago) && (user.recovery_attemps < 4))
			return true
		else
			user.recovery_attemps += 1
			user.save
			return false
		end
	end
end