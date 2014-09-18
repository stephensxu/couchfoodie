class PhotoWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(photo_id)
    puts "worker starting to process photo..."
    photo = Photo.find(photo_id)
    puts "calling recreate versions on photosuploader..."
    KitchenPhotosUploader.recreate_versions!
    puts "recreate_versions sucess..."
    photo.processed_at = Time.zone.now
    puts "worker finished processing photo..."
    photo.save!
    puts "photo is saved..."
  end
end
