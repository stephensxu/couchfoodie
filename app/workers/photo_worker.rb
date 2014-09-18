class PhotoWorker
  include Sidekiq::Worker

  def perform(photo_id)
    photo = Photo.find(photo_id)
    photo.recreate_versions!
    photo.processed_at = Time.zone.now
    photo.save!
  end
end
