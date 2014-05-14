class RegisterAttemptsController < ApplicationController

	def new

	end

	def create
		
		if valid_email?(params[:email])
			if(user_email_exists?(params[:email]))
			   flash[:error] = "User already exists. Please log in."
			   redirect_to login_path
			elsif (user_attempt_exists?(params[:email]))
				previous_attempt = RegisterAttempt.find_by(email: params[:email])
				@attempt = previous_attempt
				if(previous_attempt.created_at > 7.days.ago)
					UserMailer.send_register_email(@attempt).deliver
					flash[:notice] = "A new registration email has been sent. Please check your email to complete the registration process."
					redirect_to attempt_path
				else
					@attempt.passcode = geenerate_registration_code
					if @attempt.update
						UserMailer.send_register_email(@attempt).deliver
						flash[:notice] = "A new registration email has been sent. Please check your email to complete the registration process."
						redirect_to attempt_path
					else
						flash[:error] = "There was an error sending the registration email."
						redirect_to attempt_path
					end
				end
			else
				@attempt = RegisterAttempt.new(attempt_params)
				@attempt.email = params[:email]
				@attempt.passcode = generate_registration_code
				if @attempt.save
					UserMailer.send_register_email(@attempt).deliver
					flash[:notice] = "Welcome to World Cup Bracket. Please check your email to complete the registration process."
					redirect_to root_path
				else
					render '/register'
				end
			end
		end
	end

	private

	def attempt_params
		params.permit(:email)
	end

end