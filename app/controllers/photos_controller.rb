class PhotosController < ApplicationController
  before_action :set_kitchen
  before_action :require_authorization!
  before_action :require_login

  def index
    @photos = @kitchen.processed_photos
  end

  def create
    bench("photoscontroller#create build") { @photo = @kitchen.photos.build(photo_params) }

    if bench("photoscontroller#create save") { @photo.save }
      redirect_to kitchen_path(@kitchen), :notice => 'Photo was successfully created.'
    else
      render :new
    end
  end

  def new
    @photo = Photo.new
    if @kitchen.photos.empty?
      render 'new'
    else
      render 'add_photo'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @kitchen = @photo.kitchen
    @photo.destroy
    redirect_to kitchen_photos_path(@kitchen)
  end

  def set_as_front_page_photo
    @photo = Photo.find(params[:id])
    @kitchen = @photo.kitchen
    @kitchen.set_front_page_photo(@photo)
    redirect_to kitchen_path(@kitchen)
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

  def bench(label)
    t0 = Time.now
    puts("[#{t0}] Before: #{label}")

    result = yield

    t1 = Time.now
    puts("[#{t1}] After: #{label}")
    puts("Total: %0.2f seconds" % [t1 - t0])

    result 
  end
end
