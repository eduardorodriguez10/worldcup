class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
	@user = User.new(user_params)

		if @user.save
			flash[:notice] = "Welcome to World Cup Bracket, You are registered now."
			redirect_to new_bracket_path()
		else
			render '/register'
		end
	end

	def show
		@user = User.find(session[:user_id])
	end

	def edit
		@user = User.find(session[:user_id])
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :country, :first_name, :last_name)
	end
end