class PhotosController < ApplicationController
  def create
    @photo = @kitchen.photos.new(photo_params)

    if @photo.save
      redirect_to user_path(current_user), :notice => 'Photo was successfully created.'
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
