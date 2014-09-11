class PhotosController < ApplicationController

  def index
    @kitchen = Kitchen.find(params[:kitchen_id])
    @photos = @kitchen.photos
  end

  def create
    @kitchen = Kitchen.find(params[:kitchen_id])
    @photo = @kitchen.photos.build(photo_params)

    if @photo.save
      p "front page photo is #{@kitchen.front_page_photo}"
      redirect_to kitchens_users_path, :notice => 'Photo was successfully created.'
    else
      render :new
    end
  end

  def new
    @photo = Photo.new
  end

  def edit
  end

  def destroy
    @photo = Photo.find(params[:id])
    @kitchen = @photo.kitchen
    @kitchen.front_page_photo.destroy if @photo == @kitchen.front_page_photo
    @photo.remove_picture!
    @photo.destroy
    redirect_to kitchen_photos_path(@kitchen)
  end

  def photo_params
    params.require(:photo).permit(:picture)
  end
end
