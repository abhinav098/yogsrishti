class AsanasController < ApplicationController
	before_action :authenticate_user!
	before_action :set_asan, only: [:edit, :update, :show, :destroy]

	def index
		if params[:search]
			search = Sunspot.search(Asana) do 
									fulltext params[:search]
								end
			@asans = search.results
		else	
			@asans = Asana.order(:name)
		end
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

	def search
		search = Sunspot.search(Asana) do 
									fulltext params[:search]
								end
		@asanas_searched = search.results
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
