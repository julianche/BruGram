class PhotosController < ApplicationController
	
	before_action :authenticate_user!
	
	def index
		if current_user
			@photos = current_user.photos
	  else 
	  	redirect_to new_user_session_path, notice: 'You are not logged in.'
	  end 
	end

	def new
		@photo = current_user.photos.build
	end 

	def show
		@photo = Photo.find(params[:id])
	end 

	def create 
		@photo = current_user.photos.build(photo_params)

		if @photo.save
			redirect_to photos_path(current_user)
		else
			render 'new'
		end 
	end 

	def edit
		@photo = Photo.find(params[:id])
	end

	def destroy
		@photo = Photo.find(params[:id])
		@photo.destroy

		redirect_to photos_path
	end 

	private
    def photo_params
      params.require(:photo).permit(:image, :caption, :public)
    end

end

