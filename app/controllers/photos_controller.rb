class PhotosController < ApplicationController
  before_action :set_kitchen
  before_action :require_authorization!
  before_action :require_login

  def index
    @photos = @kitchen.photos
  end

  def create
    @photo = @kitchen.photos.build(photo_params)

    if @photo.save
      redirect_to kitchens_users_path, :notice => 'Photo was successfully created.'
    else
      render :new
    end
  end

  def new
    @photo = Photo.new
  end

  def destroy
    @photo = Photo.find(params[:id])
    @kitchen = @photo.kitchen
    @kitchen.destroy_front_page_photo if @photo == @kitchen.front_page_photo
    @photo.destroy
    redirect_to kitchen_photos_path(@kitchen)
  end

  private

  def set_kitchen
    @kitchen = Kitchen.find(params[:kitchen_id])
  end

  def require_authorization!
    redirect_to root_path unless @kitchen.editable_by?(current_user)
  end

  def require_login
    redirect_to root_path unless logged_in?
  end

  def photo_params
    params.require(:photo).permit(:picture)
  end
end
