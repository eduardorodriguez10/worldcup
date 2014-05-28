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
              update_selections
              flash[:notice] = "Your bracket has been saved."
      	      redirect_to bracket_path(@bracket)    
      	    else
      	      flash.now[:error] = "There was a problem saving the bracket. Please make sure all fields are selected."
      	      render :new
      	    end
        else
          flash.now[:error] = "Your bracket has invalid information. Please make sure all fields are selected correctly."
          render :new
        end
  end

  	def show
  		@allTeams = Team.all
  		if(Bracket.where("user_id = ?",session[:user_id]).blank?)
  			redirect_to new_bracket_path
  		elsif (params.has_key?(:other_bracket) && results_visible?)
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
           update_selections
	         redirect_to bracket_path(@bracket.id)    
	       else
	          flash.now[:error] = "There was a problem saving the bracket. Please make sure all fields are selected correctly."
	         render :edit
	       end
      else
      flash.now[:error] = "Your bracket has invalid information. Please make sure all fields are selected correctly."
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

      def update_selections
        Team.all.each do |t|
          t.r16_selections = 0
          t.quaterfinals_selections = 0
          t.semifinals_selections = 0 
          t.final_selections = 0 
          t.third_match_selections = 0
          t.champion_selections = 0
          t.third_selections = 0
          t.save
        end
        Bracket.all.each do |b|
          for i in 97..104
              for x in 1..2
                t = Team.find_by(id: b.send(i.chr+x.to_s))
                if(!t.nil?)
                  t.r16_selections +=1
                  t.save
                end
              end
          end
          for i in 49..56
              t = Team.find_by(id: b.send('w'+i.to_s))
              if(!t.nil?)
                t.quaterfinals_selections +=1
                t.save
              end
          end
          for i in 57..60
              t = Team.find_by(id: b.send('w'+i.to_s))
              if(!t.nil?)
                t.semifinals_selections +=1
                t.save
              end
          end
          for i in 61..62
              t = Team.find_by(id: b.send('w'+i.to_s))
              if(!t.nil?)
                t.final_selections +=1
                t.save
              end
          end
          for i in 61..62
              t = Team.find_by(id: b.send('l'+i.to_s))
              if(!t.nil?)
                t.third_match_selections +=1
                t.save
              end
          end
          t = Team.find_by(id: b.third)
            if(!t.nil?)
                t.third_selections +=1
                t.save
            end
          t = Team.find_by(id: b.champion)
            if(!t.nil?)
                t.champion_selections +=1
                t.save
            end
        end
      end

      def valid_bracket?
        valid_bracket = true
        for i in 97..104
          for x in 1..2
            t = Team.find_by(id: params[:bracket][i.chr+x.to_s])
            m = (x % 2) + 1
            if(!t.nil?)
              if(t.send('group') != (i - 32).chr || params[:bracket][i.chr+x.to_s]==params[:bracket][i.chr+m.to_s])
                valid_bracket = false
              end
            else
              valid_bracket = false
            end
          end
        end
        if(valid_bracket)
          if ((params[:bracket][:w49] != params[:bracket][:a1]) && (params[:bracket][:w49] != params[:bracket][:b2])) then valid_bracket = false end
          if ((params[:bracket][:w50] != params[:bracket][:c1]) && (params[:bracket][:w50] != params[:bracket][:d2])) then valid_bracket = false end
          if ((params[:bracket][:w53] != params[:bracket][:e1]) && (params[:bracket][:w53] != params[:bracket][:f2])) then valid_bracket = false end
          if ((params[:bracket][:w54] != params[:bracket][:g1]) && (params[:bracket][:w54] != params[:bracket][:h2])) then valid_bracket = false end
          if ((params[:bracket][:w57] != params[:bracket][:w49]) && (params[:bracket][:w57] != params[:bracket][:w50])) then valid_bracket = false end
          if ((params[:bracket][:w58] != params[:bracket][:w53]) && (params[:bracket][:w58] != params[:bracket][:w54])) then valid_bracket = false end
          if ((params[:bracket][:w51] != params[:bracket][:b1]) && (params[:bracket][:w51] != params[:bracket][:a2])) then valid_bracket = false end
          if ((params[:bracket][:w52] != params[:bracket][:d1]) && (params[:bracket][:w52] != params[:bracket][:c2])) then valid_bracket = false end
          if ((params[:bracket][:w55] != params[:bracket][:f1]) && (params[:bracket][:w55] != params[:bracket][:e2])) then valid_bracket = false end
          if ((params[:bracket][:w56] != params[:bracket][:h1]) && (params[:bracket][:w56] != params[:bracket][:g2])) then valid_bracket = false end
          if ((params[:bracket][:w59] != params[:bracket][:w51]) && (params[:bracket][:w59] != params[:bracket][:w52])) then valid_bracket = false end
          if ((params[:bracket][:w60] != params[:bracket][:w55]) && (parmas[:bracket][:w60] != params[:bracket][:w56])) then valid_bracket = false end
          if ((params[:bracket][:w61] != params[:bracket][:w57]) && (params[:bracket][:w61] != params[:bracket][:w58])) then valid_bracket = false end
          if ((params[:bracket][:w62] != params[:bracket][:w59]) && (params[:bracket][:w62] != params[:bracket][:w60])) then valid_bracket = false end
          if ((params[:bracket][:l61] != params[:bracket][:w57]) && (params[:bracket][:l61] != params[:bracket][:w58])) then valid_bracket = false end
          if ((params[:bracket][:l62] != params[:bracket][:w59]) && (params[:bracket][:l62] != params[:bracket][:w60])) then valid_bracket = false end
          if ((params[:bracket][:third] != params[:bracket][:l61]) && (params[:bracket][:third] != params[:bracket][:l62])) then valid_bracket = false end
          if ((params[:bracket][:champion] != params[:bracket][:w61]) && (params[:bracket][:champion] != params[:bracket][:w62])) then valid_bracket = false end
          if ((params[:bracket][:l61] == params[:bracket][:w61]) || (params[:bracket][:l61] == params[:bracket][:w62])) then valid_bracket = false end
          if ((params[:bracket][:l62] == params[:bracket][:w61]) || (params[:bracket][:l62] == params[:bracket][:w62])) then valid_bracket = false end
          if (params[:bracket][:champion] == params[:bracket][:third]) then valid_bracket = false end
        end
        return valid_bracket
      end
end