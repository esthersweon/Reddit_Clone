class PostsController < ApplicationController
	def new
		@sub = Sub.find(params[:sub_id])
		@post = Post.new
		render :new
	end

	def create
		@sub = Sub.find(params[:sub_id])
		@post = Post.new(post_params)

		if @post.save
			redirect_to sub_url(@sub)
		else
			flash.now[:errors] = @post.errors.full_messages
			render :new
		end
	end

	private
	def post_params
		params.require(:post).permit(:title, :url, :content, :sub_id, :user_id)
	end
end
