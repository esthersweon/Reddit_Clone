class SubsController < ApplicationController
	before_action :require_signed_in

	def index
		@subs = Sub.all
		render :index
	end

	def new
		@sub = Sub.new
		render :new
	end

	def show
		@sub = Sub.find(params[:id])
		@moderator = User.find(@sub.moderator_id)
		render :show
	end

	def create
		@sub = Sub.new(sub_params)

		if @sub.save
			redirect_to sub_url(@sub)
		else
			flash.now[:errors] = @sub.errors.full_messages
			render :new
		end
	end

	def edit
		@sub = Sub.find(params[:id])

		if @sub
			render :edit
		else
			flash.now[:errors] = @sub.errors.full_messages
			render :show
		end
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

	def sub_params
		params.require(:sub).permit(:title, :description, :moderator_id)
	end
end
