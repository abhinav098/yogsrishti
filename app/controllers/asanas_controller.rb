class AsanasController < ApplicationController
	before_action :authenticate_user!
	before_action :set_asan, only: [:edit, :update, :show, :destroy]

	def index
		@asans = Asana.order(:name)
	end

	def new
		@asan = Asana.new
	end

	def create
		if current_user.admin?
			@asan = Asana.create(asan_params)
			if @asan.save
				redirect_to @asan, success: "Asana Created Successfully"
			else
				render "new"
			end
		else
			redirect_to asanas_path
			flash[:error] = "You are not authorised to perform this action."
		end
	end

	def update
		if current_user.admin?
			if @asan.update(asan_params)
				redirect_to @asan, success: "Asana Updated Successfully"
			else
				render "edit"
			end
		else
			redirect_to asanas_path
			flash[:error] = "You are not authorised to perform this action."
		end
	end

  def search
		@asanas_searched = Asana.search(params[:search])
  end

	def destroy
		if current_user.admin?
			@asan.destroy
			redirect_to @asan, alert: "Asana Deleted Successfully"
		else
			redirect_to asanas_path
			flash[:error] = "You are not authorised to perform this action."
		end
	end

	private

	def set_asan
		@asan = Asana.find(params[:id])
	end
	def asan_params
		params.require(:asana).permit(:name, :description, :image)
	end
end
