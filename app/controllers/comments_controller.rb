class CommentsController < ApplicationController
	before_action :require_signed_in, only: [:new, :create]

	def new
		render :new
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params)
		@comment.submitter_id = current_user.id

		if @comment.save
			redirect_to post_url(@post)
		else
			flash[:errors] = @comment.errors.full_messages
			redirect_to new_post_comment_url(params[:post_id])
		end
	end

	def show
		@comment = Comment.find(params[:id])
		if @comment
			render :show
		else
			redirect_to subs_url
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :submitter_id, :parent_comment_id, :post_id)
	end
end
