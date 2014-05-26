class WelcomeController < ApplicationController

	
	def index
		if logged_in?
			if is_admin? && admin_view?
				redirect_to admininfo_path
			else
				redirect_to bracket_path(current_user.slug)
			end
		end
	end

	def how_does_it_work

	end

end