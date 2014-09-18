class PhotoWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(photo_id)
    puts "worker starting to process photo..."
    photo = Photo.find(photo_id)
    puts "photo object is #{photo}..."
    puts "calling process_in_background on photo.picture..."
    photo.picture.recreate_versions!(:gallery_fill, :gallery_fill_thumbnail, :gallery_fill_cover)
    # photo.picture.process_in_background
    puts "recreate_versions sucess..."
    photo.processed_at = Time.zone.now
    puts "worker finished processing photo..."
    photo.save!
    puts "photo is saved..."
  end
end
