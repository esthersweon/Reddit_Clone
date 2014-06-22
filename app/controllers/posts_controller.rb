class PostsController < ApplicationController
	before_action :require_signed_in

	def new
		@subs = Sub.all
		@post = Post.new
		render :new
	end

	def show
		@post = Post.find(params[:id])
		render :show
	end

	def create
		@post = current_user.posts.new(post_params)
		if @post.save
			redirect_to post_url(@post)
		else
			flash.now[:errors] = @post.errors.full_messages
			@subs = Sub.all
			render :new
		end
	end

	def edit
    	@subs = Sub.all
  	end

  	def update
  		if @post.update_attributes(post_params)
  			redirect_to post_url(@post)
  		else
  			flash.now[:errors] = @post.errors.full_messages
      		render :edit
  		end
  	end

	private
	def post_params
		params.require(:post).permit(:title, :url, :content, {sub_ids: []}, :user_id)
	end
end
