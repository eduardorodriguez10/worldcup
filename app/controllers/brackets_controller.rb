class BracketsController < ApplicationController
	
  before_action :require_user

  def index

	end
	def new
		@bracket = Bracket.new
    @clear = false
	end
	def create
    	@bracket = Bracket.new(bracket_params)
    	@bracket.user_id = session[:user_id]
      require_same_user(@bracket.user_id)
      	    if @bracket.save
      	      redirect_to bracket_path(@bracket)    
      	    else
              binding.pry
      	      flash[:error] = "There was a problem saving the bracket. Please make sure all fields are selected."
      	      render :new
      	    end
  end

  	def show
  		@allTeams = Team.all
  		if(Bracket.where("user_id = ?",session[:user_id]).blank?)
  			redirect_to new_bracket_path
  		elsif (params[:other_bracket])
          @bracket = Bracket.find(params[:id])
          @screen_name = params[:screen_name]
        else
  			 @bracket = Bracket.find_by(user_id: session[:user_id])
      end
  	end

  	def edit
  		if(params.has_key?(:clear))
  			@clear = params[:clear]
  		else
  			@clear = false
  		end
  		if(@clear)
  			@bracket = Bracket.find(params[:id])
        @bracket.a1 = @bracket.a2 = @bracket.b1 = @bracket.b2 = @bracket.c1 = @bracket.c2 = @bracket.d1 = @bracket.d2 = nil
  		  @bracket.e1 = @bracket.e2 = @bracket.f1 = @bracket.f2 = @bracket.g1 = @bracket.g2 = @bracket.h1 = @bracket.h2 = nil
        @bracket.w49 = @bracket.w50 = @bracket.w51 = @bracket.w52 = @bracket.w53 = @bracket.w54 = @bracket.w55 = nil
        @bracket.w56 = @bracket.w57 = @bracket.w58 = @bracket.w59 = @bracket.w60 = @bracket.w61 = @bracket.w62 = nil
        @bracket.l61 = @bracket.l62 = @bracket.third = @bracket.champion = nil
      else
			@bracket = Bracket.find(params[:id])
      require_same_user(@bracket.user_id)
		end
	end

	def update
      binding.pry
    	@bracket = Bracket.find(params[:id])
    	@bracket.id = params[:id]
    	@bracket.user_id = session[:user_id]
      require_same_user(@bracket.user_id)
	    if @bracket.update(bracket_params)
	      redirect_to bracket_path(@bracket.id)    
	    else
        binding.pry
	      flash[:error] = "There was a problem saving the bracket. Please make sure all fields are selected."
	      render :edit
	    end
  	end


  	private

  	def bracket_params
      params.require(:bracket).permit!
  	end

  	def bracket_params_update
  	  params.require(:bracket).permit!.except(:user_id)
  	end

end