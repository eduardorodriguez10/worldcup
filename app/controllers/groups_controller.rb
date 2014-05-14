class GroupsController < ApplicationController

	def index
		Membership.uncached do
			@association = Membership.select(:group_id).where(user_id: session[:user_id])
		end
		if(params.has_key?(:page))
			page_index = params[:page]
		else
			page_index = 0
		end
		if(params.has_key?(:sortby))
			page_sortby = params[:sortby]
		else
			page_sortby = 'group_name'
		end
		if(params.has_key?(:sortmode))
			page_sortmode = params[:sortmode]
		else
			page_sortmode = 'ASC'
		end
		if(params.has_key?(:showpublic))
			showpublic = params[:showpublic]
		else
			showpublic = false
		end
		if (showpublic)
			@total_public_groups = Group.where(isprivate: false).count
			if(@total_public_groups < items_per_page)
				@pagination = false
				@groups = Group.where(isprivate: false)
			else 
				@pagination = true
				@groups = Group.where(isprivate: false).order(page_sortby+' '+page_sortmode).limit(items_per_page).offset(page_index * items_per_page)
			end
		else
			Group.uncached do
				@group = Group.find_by(id: Membership.where(user_id: session[:user_id]).select(:group_id).order(last_viewed: :desc).limit(1))
				if !@group.nil? 
					redirect_to group_path(@group)
				else
					@groups = Group.where(id: @association)
				end
			end
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
			@group.leader = 0
			if(!@group.isprivate)
				@group.passcode = '000000'
			end
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
		if @group.update(group_params)
			redirect_to group_path(@group)
		else
			flash[:error] = "There was a problem updating the group"
			redirect_to group_path(slug: params[:id])
		end
	end

	def show
		@group = Group.find_by(slug: params[:id])
		membership = Membership.find_by(group_id: @group.id, user_id: session[:user_id])
		if(!membership.nil?)
			membership.last_viewed = Time.now
			membership.save
		end
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
		params.require(:group).permit(:group_name, :passcode, :isprivate)
	end

	def membership_params
		params.require(:membership).permit(:user_id, :group_id, :user_screen_name)
	end

end
