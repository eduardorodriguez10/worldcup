class StatsController < ApplicationController
	before_action :require_user

	def index
		Team.uncached do
			if(params.has_key?(:sortbyteam) && (params[:sortbyteam]=='asc' || params[:sortbyteam]=='desc'))
				@sortbyteam = params[:sortbyteam]
	            @teams = Team.all.order('name '+params[:sortbyteam])
			elsif(params.has_key?(:sortbyR16) && (params[:sortbyR16]=='asc' || params[:sortbyR16]=='desc'))
				@sortbyR16 = params[:sortbyR16]
				@teams = Team.all.order('r16_selections '+params[:sortbyR16], 'name asc')
			elsif(params.has_key?(:sortbyQF) && (params[:sortbyQF]=='asc' || params[:sortbyQF]=='desc'))
				@sortbyQF = params[:sortbyQF]
				@teams = Team.all.order('quaterfinals_selections '+params[:sortbyQF], 'r16_selections '+params[:sortbyQF])
			elsif (params.has_key?(:sortbySF) && (params[:sortbySF]=='asc' || params[:sortbySF]=='desc'))
				@sortbySF = params[:sortbySF]
				@teams = Team.all.order('semifinals_selections '+ params[:sortbySF], 'quaterfinals_selections '+params[:sortbySF], 'r16_selections '+params[:sortbySF])
			elsif (params.has_key?(:sortbyFM) && (params[:sortbyFM]=='asc' || params[:sortbyFM]=='desc'))
				@sortbyFM = params[:sortbyFM]
				@teams = Team.all.order('final_selections '+ params[:sortbyFM], 'semifinals_selections '+ params[:sortbyFM], 'quaterfinals_selections '+params[:sortbyFM], 'r16_selections '+params[:sortbyFM])
			elsif (params.has_key?(:sortbyTPM) && (params[:sortbyTPM]=='asc' || params[:sortbyTPM]=='desc'))
				@sortbyTPM = params[:sortbyTPM]
				@teams = Team.all.order('third_match_selections '+ params[:sortbyTPM], 'semifinals_selections '+ params[:sortbyTPM], 'quaterfinals_selections '+params[:sortbyTPM], 'r16_selections '+params[:sortbyTPM])
			elsif (params.has_key?(:sortbyTP) && (params[:sortbyTP]=='asc' || params[:sortbyTP]=='desc'))
				@sortbyTP = params[:sortbyTP]
				@teams = Team.all.order('third_selections '+params[:sortbyTP],'third_match_selections '+ params[:sortbyTP], 'semifinals_selections '+ params[:sortbyTP], 'quaterfinals_selections '+params[:sortbyTP], 'r16_selections '+params[:sortbyTP])
			elsif (params.has_key?(:sortbyCP) && (params[:sortbyCP]=='asc' || params[:sortbyCP]=='desc'))
				@sortbyCP = params[:sortbyCP]
				@teams = Team.all.order('champion_selections '+params[:sortbyCP],'final_selections '+ params[:sortbyCP], 'semifinals_selections '+ params[:sortbyCP], 'quaterfinals_selections '+params[:sortbyCP], 'r16_selections '+params[:sortbyCP])
			else	
				@teams = Team.all.order(champion_selections: :desc, final_selections: :desc, third_selections: :desc, third_match_selections: :desc)
			end
		end
	end

end