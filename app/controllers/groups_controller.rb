class GroupsController < ApplicationController

	def index
		Membership.uncached do
			@association = Membership.select(:group_id).where(user_id: session[:user_id])
		end
		Group.uncached do
			@groups = Group.where(id: @association)
		end
	end

	def new
		@join = false
		@group = Group.new
		@join = params[:join]
	end

	def create
			@group = Group.new(group_params)
			@group.organizer = session[:user_id]
		    if @group.save
		        @membership = Membership.new
				@membership.user_id = session[:user_id]
				@membership.group_id = @group.id
				@membership.user_screen_name = params[:screenname]
				if @membership.save
		     		 redirect_to groups_path()
		     	else
		     		@group.destroy
		     		redirect_to new_group_path()
		     	end
		    else
		      render 'new'
		    end
	end

	def edit 
		@group = Group.find_by(slug: params[:id])
	end

	def update
		@group = Group.find_by(slug: params[:id])
		binding.pry
		if @group.update(group_params)
			redirect_to group_path(@group)
		else
			flash[:error] = "There was a problem updating the group"
			redirect_to group_path(slug: params[:id])
		end
	end

	def show
		@group = Group.find_by(slug: params[:id])
	end

	def destroy
		@group = Group.find_by(slug: params[:id])
		@memberships = Membership.where(group_id: params[:id])
		if @memberships.destroy_all
			@group.destroy
			redirect_to groups_path()
		else
			flash[:error] = "Error while deleting group."
		end
	end


	private

	def group_params
		params.require(:group).permit(:group_name, :passcode)
	end

	def membership_params
		params.require(:membership).permit(:user_id, :group_id, :user_screen_name)
	end

end
