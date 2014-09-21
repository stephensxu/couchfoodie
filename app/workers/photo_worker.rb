class PhotoWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(photo_id)
    photo = Photo.find(photo_id)
    photo.picture.recreate_versions!(:gallery_fill, :gallery_fill_thumbnail, :gallery_fill_cover)
    photo.processed_at = Time.zone.now
    photo.save!
  end
end
