class CommentsController < ApplicationController
	def new
		@comment = Comment.new
		render :new
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(comment_params)

		if @comment.save
			redirect_to post_url(@post)
		else
			flash[:errors] = @comment.errors.full_messages
			redirect_to post_url(@post)
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :submitter_id, :parent_comment_id, :post_id)
	end
end
