class AdminController < ApplicationController
	before_action :require_user, :require_admin
	include ApplicationHelper

	def index

	end

	def change_view
		if(params[:view]=="true")
			current_user.admin_view = true
			current_user.save
			redirect_to root_path
		else
			current_user.admin_view = false
			current_user.save
			redirect_to root_path
		end
	end

	def user_search

	end

	def admin_info

	end

	def team_index

	end

	def team_edit
		@team = Team.find(params[:id])
	end

	def team_update
		@team = Team.find(params[:id])
		params[:team][:r16_position] = @team.group.downcase + params[:team][:r16_position]
		if @team.update(team_params)
			flash[:notice] = "The team has been updated."
			update_all_scores
			update_all_memberships
			redirect_to teamedit_path(@team)
		else
			flash[:error] = "There was a problem updating the team"
			redirect_to teamedit_path(@team)
		end
	end

	private

	def team_params
		params.require(:team).permit(:r16_position, :r16_madeit, :r16_defined, :quaterfinals_position, :quaterfinals_madeit, :quaterfinals_defined, :semifinals_position, :semifinals_madeit, :semifinals_defined,  :final_madeit, :final_defined, :third_match_madeit, :third_match_defined, :third_place_madeit, :third_place_defined, :champion_madeit, :champion_defined)
	end
end