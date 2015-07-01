class PhotosController < ApplicationController
	
	before_action :authenticate_user!
	
	#users/:user_id/photos
	def index
		#find apprprocate user 
		user = User.find(params[:user_id])
		if current_user == user
			@photos = current_user.photos
	  else 
	  	@photos = user.photos.where(public: true)
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
			redirect_to user_photos_path(current_user)
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

	def show_all 
		@photos = Photo.where(public:true)

	end 

	private
    def photo_params
      params.require(:photo).permit(:image, :caption, :public)
    end

end

