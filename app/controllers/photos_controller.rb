class PhotosController < ApplicationController
  def create
    # @kitchen = Kitchen.find(params[:kitchen_id])
    # @photo = @kitchen.photos.build(photo_params)
    # @photo = @kitchen.photos.new(photo_params)
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to kitchens_users_path, :notice => 'Photo was successfully created.'
    else
      render :new
    end
  end

  def new
    @photo = Photo.new
  end

  def photo_params
    params.require(:photo).permit(:picture)
  end
end
