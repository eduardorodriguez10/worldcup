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
        if valid_bracket?
      	    if @bracket.save
      	      redirect_to bracket_path(@bracket)    
      	    else
      	      flash[:error] = "There was a problem saving the bracket. Please make sure all fields are selected."
      	      render :new
      	    end
        else
          flash[:error] = "Your bracket has invalid information. Please make sure all fields are selected correctly."
          render :new
        end
  end

  	def show
  		@allTeams = Team.all
  		if(Bracket.where("user_id = ?",session[:user_id]).blank?)
  			redirect_to new_bracket_path
  		elsif (params[:other_bracket])
          @bracket = Bracket.find_by(slug: params[:id])
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
  			@bracket = Bracket.find_by(slug: params[:id])
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
    	@bracket = Bracket.find_by(slug: params[:id])
    	@bracket.user_id = session[:user_id]
      require_same_user(@bracket.user_id)
      if valid_bracket?
	       if @bracket.update(bracket_params)
	         redirect_to bracket_path(@bracket.id)    
	       else
	          flash[:error] = "There was a problem saving the bracket. Please make sure all fields are selected."
	         render :edit
	       end
      else
      flash[:error] = "Your bracket has invalid information. Please make sure all fields are selected correctly."
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

      def valid_bracket?
        valid_bracket = true
        for i in 97..104
          for x in 1..2
            t = Team.find_by(id: @bracket.send(i.chr+x.to_s))
            m = (x % 2) + 1
            if(!t.nil?)
              if(t.send('group') != (i - 32).chr || @bracket.send(i.chr+x.to_s)==@bracket.send(i.chr+m.to_s))
                valid_bracket = false
              end
            else
              valid_bracket = false
            end
          end
        end
        if(valid_bracket)
          if ((@bracket.w49 != @bracket.a1) && (@bracket.w49 != @bracket.b2)) then valid_bracket = false end
          if ((@bracket.w50 != @bracket.c1) && (@bracket.w50 != @bracket.d2)) then valid_bracket = false end
          if ((@bracket.w53 != @bracket.e1) && (@bracket.w53 != @bracket.f2)) then valid_bracket = false end
          if ((@bracket.w54 != @bracket.g1) && (@bracket.w54 != @bracket.h2)) then valid_bracket = false end
          if ((@bracket.w57 != @bracket.w49) && (@bracket.w57 != @bracket.w50)) then valid_bracket = false end
          if ((@bracket.w58 != @bracket.w53) && (@bracket.w58 != @bracket.w54)) then valid_bracket = false end
          if ((@bracket.w51 != @bracket.b1) && (@bracket.w51 != @bracket.a2)) then valid_bracket = false end
          if ((@bracket.w52 != @bracket.d1) && (@bracket.w52 != @bracket.c2)) then valid_bracket = false end
          if ((@bracket.w55 != @bracket.f1) && (@bracket.w55 != @bracket.e2)) then valid_bracket = false end
          if ((@bracket.w56 != @bracket.h1) && (@bracket.w56 != @bracket.g2)) then valid_bracket = false end
          if ((@bracket.w59 != @bracket.w51) && (@bracket.w59 != @bracket.w52)) then valid_bracket = false end
          if ((@bracket.w60 != @bracket.w55) && (@bracket.w60 != @bracket.w56)) then valid_bracket = false end
          if ((@bracket.w61 != @bracket.w57) && (@bracket.w61 != @bracket.w58)) then valid_bracket = false end
          if ((@bracket.w62 != @bracket.w59) && (@bracket.w62 != @bracket.w60)) then valid_bracket = false end
          if ((@bracket.l61 != @bracket.w57) && (@bracket.l61 != @bracket.w58)) then valid_bracket = false end
          if ((@bracket.l62 != @bracket.w59) && (@bracket.l62 != @bracket.w60)) then valid_bracket = false end
          if ((@bracket.third != @bracket.l61) && (@bracket.third != @bracket.l62)) then valid_bracket = false end
          if ((@bracket.champion != @bracket.w61) && (@bracket.champion != @bracket.w62)) then valid_bracket = false end
          if ((@bracket.l61 == @bracket.w61) || (@bracket.l61 == @bracket.w62)) then valid_bracket = false end
          if ((@bracket.l62 == @bracket.w61) || (@bracket.l62 == @bracket.w62)) then valid_bracket = false end
          if (@bracket.champion == @bracket.third) then valid_bracket = false end
        end
        return valid_bracket
      end
end