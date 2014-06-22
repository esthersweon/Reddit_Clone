class SubsController < ApplicationController
	before_action :require_signed_in
	before_action :user_owns_sub?, only: [:edit, :update]

	def index
		@subs = Sub.all
		render :index
	end

	def new
		@sub = Sub.new
		5.times {@sub.posts.new}

		render :new
	end

	def show
		@sub = Sub.find(params[:id])
		# @moderator = User.find(@sub.moderator_id)
		render :show
	end

	def create
		@sub = current_user.subs.new(sub_params)
		filled_out_posts = params[:posts].values.reject do |value|
      		value[:url].empty? || value[:title].empty?
    	end

    	filled_out_posts.each do |post_params|
      		@sub.posts.new(post_params.merge(user_id: current_user.id))
    	end

		if @sub.save
			redirect_to sub_url(@sub)
		else
			flash.now[:errors] = @sub.errors.full_messages
			render :new
		end
	end

	def edit
		# @sub = Sub.find(params[:id])
		render :edit
	end

	def update
		@sub = Sub.find(params[:id])

		if @sub.update_attributes(sub_params)
			redirect_to sub_url(@sub)
		else
			flash.now[:errors] = @sub.errors.full_messages
			render :edit
		end
	end

	def destroy
		@sub = Sub.find(params[:id])
		@sub.destroy
		redirect_to subs_url
	end

	private

	def user_owns_sub?
    	redirect_to subs_url unless @sub.moderator == current_user
  	end

	def sub_params
		params.require(:sub).permit(:title, :moderator_id)
	end
end
