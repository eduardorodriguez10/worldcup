class AdminController < ApplicationController
	before_action :require_user, :require_admin

	def index

	end

end