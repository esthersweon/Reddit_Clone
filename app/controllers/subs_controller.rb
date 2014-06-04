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
		render :show
	end

	def create
		@sub = Sub.new(sub_params)

		if @sub.save
			redirect_to subs_url
		else
			flash.now[:errors] = @sub.errors.full_messages
			render :new
		end
	end

	private

	def sub_params
		params.require(:sub).permit(:title, :description, :moderator_id)
	end
end
