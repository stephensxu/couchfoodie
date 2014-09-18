class PhotoWorker
  include Sidekiq::Worker

  def perform
    puts "Doing hard work"
  end
end
