class BracketPlacementsController < ApplicationController
	def index
		@bp = BracketPlacement.new
	end
end