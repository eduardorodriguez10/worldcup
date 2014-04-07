class BracketsController < ApplicationController
	def new
		@bracket = Bracket.new
	end
	def create
    	@bracket = Bracket.new(bracket_params)

    	@bracket.user_id = 1
	    if @bracket.save
	      flash[:notice] = "Your bracket was saved."
	      redirect_to bracket_path    
	    else
	      flash[:error] = "There was a problem saving the bracket. Please make sure all fields are selected."
	      render :new
	    end
  	end
  	def show
  		@allTeams = Team.all
  		@bracket = Bracket.find(params[:id])
  	end

  	private

  	def bracket_params
      params.require(:bracket).permit!
  	end
end