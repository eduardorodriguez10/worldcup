class WelcomeController < ApplicationController

	
	def index
		if logged_in?
			redirect_to bracket_path(current_user.slug)
		end
	end

end