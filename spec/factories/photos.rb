# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  picture            :string(255)      not null
#  created_at         :datetime
#  updated_at         :datetime
#  kitchen_id         :integer          not null
#  picture_tmp        :string(255)
#  processed_at       :datetime
#  picture_processing :boolean          default(FALSE), not null
#
# Indexes
#
#  index_photos_on_kitchen_id  (kitchen_id)
#



FactoryGirl.define do
  factory :photo do |p|
    p.picture Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/photos/photo_for_rspec.png')))
    p.kitchen { FactoryGirl.create(:kitchen) }
    p.picture_processing :false
  

    p.trait :with_kitchen do
      kitchen
    end

    factory :photo_with_kitchen, :traits => [:with_kitchen]
  end
end
