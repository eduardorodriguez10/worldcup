class MembershipsController < ApplicationController

	def new
		@membership = Membership.new
		@membership.group_id = params[:group_id]
		@membership.user_id = current_user
		@membership.user_screen_name = current_user.screenname
		@group = Group.find_by(id: @membership.group_id)
		if (params[:isprivate] == "false")
			@isprivate = false
		else
			@isprivate = true
		end
	end

	def create
		@membership = Membership.new(membership_create_params)
		@membership.user_id = session[:user_id]
		@membership.group_id = params[:group_id].to_i
		@membership.user_screen_name = current_user.screenname
		@group = Group.find(@membership.group_id)
		if(@group.passcode == params[:passcode] || (params[:isprivate] == "false"))
			if @membership.save
				flash[:notice] = "You have successfully joined the group."
				redirect_to groups_path()
			else	     
				flash[:error] = "There was a problem joining the group."
			    render 'new'
			end
		else
			flash[:error] = "Invalid Passcode. Please try again."
			redirect_to :back
		end
	end

	def update
		@membership = Membership.find(params[:id])
		@membership.user_screen_name = params[:user_screen_name]
		@membership.update(membership_params)
		redirect_to :back
	end

	def destroy
		group = Group.find_by(slug: params[:id])
		@membership = Membership.find_by(group_id: group.id, user_id: session[:user_id])
		if @membership.nil? 
			flash[:error] = "Error trying to leave group."
			redirect_to groups_path()
		else
			@membership.destroy
			redirect_to groups_path()
		end

	end

	private

	def membership_params
		params.require(:membership).permit(:user_id, :group_id, :user_screen_name)
	end
	def membership_create_params
		params.permit(:user_id, :group_id, :user_screen_name)
	end

end