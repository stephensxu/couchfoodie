CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV['AMAZON_S3_BUCKET_NAME']
  config.aws_acl    = :public_read
  # config.asset_host = 'https://couchfoodie.s3.amazonaws.com'
  config.asset_host = ENV['AWS_ASSET_HOST_URL']
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }
end

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

  CarrierWave::Uploader::Base.descendants.each do |picture|
    next if picture.anonymous?
    picture.class_eval do
      
      storage :file

      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end
