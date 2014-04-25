class MembershipsController < ApplicationController

	def new
		@membership = Membership.new
	end

	def create
		@membership = Membership.new(membership_params)
		@membership.user_id = session[:user_id]
		@membership.group_id = params[:group_id].to_i
		@group = Group.find(@membership.group_id)
		if(@group.passcode == params[:passcode])
			if @membership.save
				redirect_to groups_path()
			else
			     
			    render 'new'
			end
		else
			flash[:error] = "Invalid Passcode. Please try again."
		end
	end

	def update
		@membership = Membership.find(params[:id])
		@membership.user_screen_name = params[:user_screen_name]
		@membership.update(membership_params)
		redirect_to :back
	end

	def destroy

		@membership = Membership.find_by(group_id: params[:id], user_id: session[:user_id])
		if @membership.nil? 
			flash[:error] = "Error trying to leave group."
		else
			@membership.destroy
			redirect_to groups_path()
		end

	end

	private

	def membership_params
		params.require(:membership).permit(:user_id, :group_id, :user_screen_name)
	end

end